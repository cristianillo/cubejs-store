cube(`Purchases`, {
  sql: `SELECT * FROM store.purchases`,
  title: `Compras`,
  joins: {
    Buyers: {
      sql: `${CUBE}.buyer_id = ${Buyers.id}`,
      relationship: `belongsTo`
    }
    
  },
  
  measures: {
    count: {
      title: `Contar`,
      type: `number`,
      sql: `count(*)`
      //shown: false
    },
    
    amount: {
      sql: `amount`,
      type: `sum`,
      shown: false
    },
    
    totalPrice: {
      title: `Suma Precio`,
      sql: `total_price`,
      type: `sum`,
      //shown: false
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
      title: `Fecha Creación`,
      sql: `create_at`,
      type: `time`,
      //shown: false
    },
    
    updateAt: {
      sql: `update_at`,
      type: `time`,
      shown: false
    },

    paymentType: {
      title: `Tipo de pago`,
      type: `string`,
      case: {
        when: [
          {sql: `${CUBE.creditCard} = true`, label: `Tarjeta de Crédito`},
          {sql: `${CUBE.accountBank} = true`, label: `Cuenta Bancaria`},
          {sql: `${CUBE.bankDeposit} = true`, label: `Depósito Bancario`}
        ],
        else: { label: `Otro medio de pago`}
      }
    }
  },
  segments: {
    onlyAccountBank:{
      title: `Cuenta Bancaria`,
      sql: `${CUBE.paymentType} = 'Cuenta Bancaria'`
    },
    onlyCreditCard:{
      title: `Tarjeta de Crédito`,
      sql: `${CUBE.paymentType} = 'Tarjeta de Crédito'`
    },
    onlyBankDeposit:{
      title: `Depósito Bancario`,
      sql: `${CUBE.paymentType} = 'Depósito Bancario'`
    }
  }
});
