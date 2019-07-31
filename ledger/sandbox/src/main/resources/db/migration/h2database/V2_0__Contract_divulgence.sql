-- Copyright (c) 2019 Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
-- SPDX-License-Identifier: Apache-2.0

---------------------------------------------------------------------------------------------------
-- V2: Contract divulgence
--
-- This schema version adds a table for tracking contract divulgence.
-- This is required for making sure contracts can only be fetched by parties that see the contract.
---------------------------------------------------------------------------------------------------



CREATE TABLE contract_divulgences (
  contract_id   varchar  not null,
  -- The party to which the given contract was divulged
  party         varchar  not null,
  -- The offset at which the contract was divulged to the given party
  ledger_offset bigint   not null,
  -- The transaction ID at which the contract was divulged to the given party
  transaction_id varchar not null,

  foreign key (contract_id) references contracts (id),
  foreign key (ledger_offset) references ledger_entries (ledger_offset),
  foreign key (transaction_id) references ledger_entries (transaction_id),

  CONSTRAINT contract_divulgences_idx UNIQUE(contract_id, party)
);
