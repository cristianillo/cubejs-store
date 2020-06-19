cube(`Purchases`, {
  sql: `SELECT * FROM store.purchases`,
  
  joins: {
    Buyers: {
      sql: `${CUBE}.buyer_id = ${Buyers.id}`,
      relationship: `belongsTo`
    }
    
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id, updateAt],
      shown: false
    },
    
    amount: {
      sql: `amount`,
      type: `sum`,
      shown: false
    },
    
    totalPrice: {
      sql: `total_price`,
      type: `sum`,
      shown: false
    }
  },
  
  dimensions: {
    code: {
      sql: `code`,
      type: `string`,
      shown: false
    },
    
    creditCard: {
      sql: `credit_card`,
      type: `string`,
      shown: false
    },
    
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
    },
    
    accountBank: {
      sql: `account_bank`,
      type: `string`,
      shown: false
    },
    
    bankDeposit: {
      sql: `bank_deposit`,
      type: `string`,
      shown: false
    },
    
    createAt: {
      sql: `create_at`,
      type: `time`,
      shown: false
    },
    
    updateAt: {
      sql: `update_at`,
      type: `time`,
      shown: false
    }
  }
});
