class Client < ApplicationRecord
    belongs_to :user

    @@queue = nil;
end
