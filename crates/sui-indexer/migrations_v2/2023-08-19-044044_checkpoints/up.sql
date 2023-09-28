CREATE TABLE checkpoints
(
    sequence_number                     bigint       PRIMARY KEY,
    checkpoint_digest                   VARCHAR(255)        NOT NULL,
    epoch                               bigint       NOT NULL,
    -- total transactions in the network at the end of this checkpoint (including itself)
    network_total_transactions          bigint       NOT NULL,
    previous_checkpoint_digest          VARCHAR(255),
    -- if this checkpoitn is the last checkpoint of an epoch
    end_of_epoch                        boolean      NOT NULL,
    -- array of TranscationDigest in bytes included in this checkpoint
    tx_digests                          JSON     NOT NULL,
    timestamp_ms                        BIGINT       NOT NULL,
    total_gas_cost                      BIGINT       NOT NULL,
    computation_cost                    BIGINT       NOT NULL,
    storage_cost                        BIGINT       NOT NULL,
    storage_rebate                      BIGINT       NOT NULL,
    non_refundable_storage_fee          BIGINT       NOT NULL,
    -- bcs serialized Vec<CheckpointCommitment> bytes
    checkpoint_commitments              BLOB        NOT NULL,
    -- bcs serialized AggregateAuthoritySignature bytes
    validator_signature                 BLOB        NOT NULL,
    -- bcs serialzied EndOfEpochData bytes, if the checkpoint marks end of an epoch
    end_of_epoch_data                   BLOB
);

CREATE INDEX checkpoints_epoch ON checkpoints (epoch);
CREATE INDEX checkpoints_digest USING HASH ON checkpoints (checkpoint_digest);
