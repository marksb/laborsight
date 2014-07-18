module Grade
  LOWER_LIMIT = 0

  flsa_bw_per_ee_atp = :flsa_bw_atp_amt / :flsa_ee_atp_cnt 


  GRADING_SCALE = {
    :flsa_violation_count => {
      0             => 100,
      (1..50)       => 80,
      (51..150)     => 60,
      (151..300)    => 40
    },
    :flsa_repeat_violator => {
      "N/A"         => 100,
      "R"           => 20,
      "W"           => 20,
      "RW"          => 10
    },
    :bw_atp_amt => {
      0             => 100,
      (1..500)      => 80,
      (501..5000)   => 60,
      (5001..50000) => 40
    },
    :flsa_ee_atp_count => {
      0             => 100,
      (1..50)       => 80,
      (51..150)     => 60,
      (151..300)    => 40
    },
    :flsa_cl_cmp_assd_amt => {
      0             => 100,
      (1..2000)     => 60,
      (2001..5000)  => 40,
      (5001..15000) => 20
    },
    :flsa_cl_violtn_count => {
      0             => 100,
      1             => 60,
      (2..100)      => 40
    },
    :flsa_cl_violtn_count => {
      0             => 100,
      1             => 60,
      (2..100)      => 40
    },
    :flsa_cl_cmp_assd_amt => {
      0             => 100,
      (1..2000)     => 60,
      (2001..5000)  => 40,
      (5001..15000) => 20
    },
    :flsa_cl_violtn_count => {
      0             => 100,
      1             => 60,
      (2..100)      => 40
    },
    :flsa_cl_minor_count => {
      0             => 100,
      1             => 60
    },
    :flsa_cl_cmp_assd_amt => {
      0             => 100,
      (1..2000)     => 60,
      (2001..5000)  => 40,
      (5001..15000) => 20
    },
    :Flsa_bw_per_ee_atp => {
      0             => 100,
      (1..500)      => 80,
      (501..5000)   => 60,
      (5001..50000) => 40
    }
  }

  def calculate_rating

    flsa_avg = (flsa_bw_atp_amt_grade + flsa_bw_per_ee_atp_grade + flsa_violation_count_grade + flsa_ee_atp_count_grade + flsa_cmp_assd_amt_grade) / 3 

    child_labor_avg = (flsa_cl_violtn_count_grade + flsa_cl_minor_count_grade + flsa_cl_cmp_assd_amt_grade)/3

    composite Score = [child_labor_avg + flsa_avg + (flsa_repeat_violator_grade * 2)] / 4 
    
  end

  def method_missing(method_sym, *args, &block)
    column = method_sym.to_s.sub("_grade","").to_sym

    if method_sym.to_s =~ /_grade/ && GRADING_SCALE[column]
      column_value = self.send(column)

      GRADING_SCALE[column].each do |key, value|
        return value if column_value == key || key.is_a?(Range) && key.include?(column_value)
      end

      return LOWER_LIMIT
    end

    super(method_sym, *args, &block)
  end

  def assign_letter_grade
    case calculate_rating
      when (90..100)
        "A"
      when (80..89)
        "B"
      when (70..79)
        "C"
      when (60..69)
        "D"
      when (0..59)
        "F"
    end
  end
end
