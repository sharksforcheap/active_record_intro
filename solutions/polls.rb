require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => 'db/polls.db'

class Poll < ActiveRecord::Base
  has_many :responses # poll.responses
  has_many :votes     # poll.votes
  
  belongs_to :author, :class_name => 'User'
  # poll.author will now return a User object
  #
  # If we did belongs_to :user we wouldn't need to tell Rails
  # the class name or the foreign key. It could infer it from
  # the name of the association, viz., :user
  #
  # On the other hand, poll.author is clearer than poll.user

  has_many :voters, :through => :votes, :source => :user
  # Again, we could say has_many :users, :through => :votes
  # and it would "just work," but poll.voters is much clearer
  # than poll.users.
end

class User < ActiveRecord::Base
  has_many :votes # user.votes

  has_many :polls_authored, :class_name => 'Poll'
  
  # :source => :poll tells ActiveRecord which association to
  # use on the join table.
  #
  # In this case it looks for the belongs_to :poll association, 
  # which tells the Vote how to get to the Poll
  has_many :polls_voted_in, :through => :votes, :source => :poll
  
  # Like above, user.polls_authored and user.polls_voted_in are
  # clearer than the alternatives.  It would also be unclear
  # whether user.polls meant "the polls the user created"
  # or "the polls the user voted in"
end

class Response < ActiveRecord::Base
  belongs_to :poll # response.poll
  
  has_many :votes
  has_many :voters, :through => :votes, :source => :user
end

class Vote < ActiveRecord::Base
  belongs_to :user     # vote.user
  belongs_to :poll     # vote.poll
  belongs_to :response # vote.response
end
