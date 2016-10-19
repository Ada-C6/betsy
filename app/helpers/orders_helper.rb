module OrdersHelper
  def us_states
      [
        ['Alabama', 'Alabama'],
        ['Alaska', 'Alaska'],
        ['Arizona', 'Arizona'],
        ['Arkansas', 'Arkansas'],
        ['California', 'California'],
        ['Colorado', 'Colorado'],
        ['Connecticut', 'Connecticut'],
        ['Delaware', 'Delaware'],
        ['District of Columbia','District of Columbia'],
        ['Florida', 'Florida'],
        ['Georgia', 'Georgia'],
        ['Hawaii', 'Hawaii'],
        ['Idaho', 'Idaho'],
        ['Illinois', 'Illinois'],
        ['Indiana', 'Indiana'],
        ['Iowa', 'Iowa'],
        ['Kansas', 'Kansas'],
        ['Kentucky', 'Kentucky'],
        ['Louisiana', 'Louisiana'],
        ['Maine', 'Maine'],
        ['Maryland', 'Maryland'],
        ['Massachusetts', 'Massachusetts'],
        ['Michigan', 'Michigan'],
        ['Minnesota', 'Minnesota'],
        ['Mississippi', 'Mississippi'],
        ['Missouri', 'Missouri'],
        ['Montana', 'Montana'],
        ['Nebraska', 'Nebraska'],
        ['Nevada', 'Nevada'],
        ['New Hampshire', 'New Hampshire'],
        ['New Jersey', 'New Jersey'],
        ['New Mexico', 'New Mexico'],
        ['New York', 'New York'],
        ['North Carolina', 'North Carolina'],
        ['North Dakota', 'North Dakota'],
        ['Ohio', 'Ohio'],
        ['Oklahoma', 'Oklahoma'],
        ['Oregon', 'Oregon'],
        ['Pennsylvania', 'Pennsylvania'],
        ['Puerto Rico', 'Puerto Rico'],
        ['Rhode Island', 'Rhode Island'],
        ['South Carolina', 'South Carolina'],
        ['South Dakota', 'South Dakota'],
        ['Tennessee', 'Tennessee'],
        ['Texas', 'Texas'],
        ['Utah', 'Utah'],
        ['Vermont', 'Vermont'],
        ['Virginia', 'Virginia'],
        ['Washington', "Washington"],
        ['West Virginia', 'West Virginia'],
        ['Wisconsin', 'Wisconsin'],
        ['Wyoming', 'Wyoming']
      ]
  end

  def months_in_year
    [
      ['January', 'January'],
      ['February', 'February'],
      ['March', 'March'],
      ['April', 'April'],
      ['May', 'May'],
      ['June', 'June'],
      ['July', 'July'],
      ['August', 'August'],
      ['September','September'],
      ['October', 'October'],
      ['November', 'November'],
      ['December', 'December']
    ]
  end

  def expiration_year
    [
      [Time.now.year, Time.now.year],
      [(Time.now.year + 1), (Time.now.year + 1)],
      [(Time.now.year + 2), (Time.now.year + 2)],
      [(Time.now.year + 3), (Time.now.year + 3)],
      [(Time.now.year + 4), (Time.now.year + 4)],
      [(Time.now.year + 5), (Time.now.year + 5)],
      [(Time.now.year + 6), (Time.now.year + 6)],
      [(Time.now.year + 7), (Time.now.year + 7)],
      [(Time.now.year + 8), (Time.now.year + 8)],
      [(Time.now.year + 9), (Time.now.year + 9)],
      [(Time.now.year + 10), (Time.now.year + 10)]
    ]
  end
end
