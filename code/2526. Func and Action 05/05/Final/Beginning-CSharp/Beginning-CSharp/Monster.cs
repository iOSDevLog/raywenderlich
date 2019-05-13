using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beginning_CSharp
{
    struct Monster
    {
        public string Name { get; set; }
        public bool DoubleDamage { get; set; }

        public int Damage
        {
            get
            {
                if (DoubleDamage)
                {
                    return _damage * 2;
                }
                return _damage;
            }
            set
            {
                _damage = value;
            }
        }
        private int _damage;


    }
}
