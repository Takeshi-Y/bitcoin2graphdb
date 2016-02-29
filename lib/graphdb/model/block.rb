module Graphdb
  module Model
    class Block < ActiveNodeBase

      property :block_hash, index: :exact, constraint: :unique
      property :size, type: Integer
      property :height, type: Integer
      property :version
      property :merkle_root
      property :time, type: Time
      property :nonce, type: Integer
      property :bits
      property :difficulty
      property :chain_work
      property :previous_block_hash
      property :next_block_hash
      property :created_at
      property :updated_at

      has_many :in, :transactions, origin: :block

      def self.from_block_height(block_height)
        block = new
        block.block_hash = Bitcoin2Graphdb::Bitcoin.provider.block_hash(block_height)
        hash = Bitcoin2Graphdb::Bitcoin.provider.block(block.block_hash)
        block.size = hash['size']
        block.height = hash['height']
        block.version = hash['version']
        block.merkle_root = hash['merkleroot']
        block.time = Time.at(hash['time'])
        block.nonce = hash['nonce']
        block.bits = hash['bits']
        block.difficulty = hash['difficulty']
        block.chain_work = hash['chainwork']
        block.previous_block_hash = hash['previouseblockhash']
        block.next_block_hash = hash['nextblockhash']
        block
      end

    end
  end
end