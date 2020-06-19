const SOUTH_AMERICA_CODES = ['ARG','BOL','BRA',
                            'CHL','COL','ECU',
                            'FLK','GUF','GUF',
                            'GUY','PRY','PER',
                            'SUR','URY','VEN'
                            ];
cube(`Buyers`, {
  sql: `SELECT * FROM store.buyers`,
  title: `Compradores`,
  description: `Cubo de compradores`,
  sqlAlias: `by`,
  //extends:
  
  joins: {
    Countries: {
      sql: `${CUBE}.country_id = ${Countries}.id`,
      relationship: `hasOne`
    }
  },
  
  measures: {
    // count: {
    //   type: `number`,
    //   sql: `count(*)`,
    //   title: `Contar`,
    //   description: `Información de la medida`,
    //   //shown: true,
    //   filters: [
    //     {
    //       sql: `${CUBE}.id > 5`
    //     }
    //   ],
    //   drillMembers: [id, name, updateAt]
    // },
    count: {
      type: `number`,
      sql: `count(*)`,
      shown: false

    },
    countAge: {
      type: `number`,
      sql: `sum(${CUBE.age})`,
      shown: false
    }
  },
  
  dimensions: {
    email: {
      sql: `email`,
      type: `string`,
      title: `Correo electrónico`,
      description: `Descripción de email`,
      shown: false
    },
    
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
    },

    age: {
      type: `number`,
      sql: `age`,
      shown: false    
    },

    buyersCountSubQuery: {
      sql: `${Countries.count}`,
      type: `number`,
      subQuery: true,
      shown: false
    },

    ageString: {
      type: `string`,
      case: {
        when: [
          { 
            sql: `${CUBE.age} > 30`,
            label: `Viejo`
          }
        ],
        else: {
          label: `Joven`
        }
      },
      shown: false
    },
    
    address: {
      sql: `address`,
      type: `string`,
      shown: false

    },
    
    name: {
      sql: `name`,
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
  },

  segments: {
    //southAmerica: {
      //title: `Sur América`,
      //sql: `${Countries.code} in ('${SOUTH_AMERICA.join("','")}')`,
    //}
  }
});

// cube(`ExtendsBuyers`,{
//   extends: Buyers,
//   title: `Compradores Extendido`,
//   measures: {
//     doubleCount: {
//       type: `number`,
//       sql: `${count} * 2`
//     }
//   }
// }
// );
