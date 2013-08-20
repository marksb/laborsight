module Grade
  LOWER_LIMIT = 0

  GRADING_SCALE = {
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
    :flsa_repeat_violator => {
      "N/A"         => 100,
      "R"           => 20,
      "W"           => 20,
      "RW"          => 10
    },
    :flsa_violation_count => {
      0             => 100,
      (1..50)       => 80,
      (51..150)     => 60,
      (151..300)    => 40
    },
    :flsa_ee_atp_count => {
      0             => 100,
      (1..50)       => 80,
      (51..150)     => 60,
      (151..300)    => 40
    },
    :bw_atp_amt => {
      0             => 100,
      (1..500)      => 80,
      (501..5000)   => 60,
      (5001..50000) => 40
    },
    :mspa_violtn_cnt => {
      0              => 100,
      (1..5)         => 60
    },
    :mspa_bw_atp_amt => {
      0              => 100,
      (1..2000)      => 80,
      (2001..10000)  => 60,
      (10001..25000) => 40
    },
    :mspa_ee_atp_cnt => {
      0              => 100,
      (1..20)        => 80,
      (21..100)      => 60,
      (101..200)     => 40
    },
    :mspa_cmp_assd_amt => {
      0              => 100,
      (1..500)       => 80,
      (501..2000)    => 60,
      (2001..7500)   => 40
    },
    :fmla_violtn_cnt => {
      0              => 100,
      (1..10)        => 80,
      (11..100)      => 60,
      (101..1000)    => 40
    },
    :fmla_bw_atp_amt => {
      0              => 100,
      (1..10)        => 80,
      (11..100)      => 60,
      (101..1000)    => 40
    },
    :fmla_ee_atp_cnt => {
      0              => 100,
      1              => 80,
      (2..5)         => 60,
      (6..25)        => 40
    },
    :fmla_cmp_assd_amt => {
      0              => 100
    },
    :h1b_violtn_cnt  => {
      0              => 100,
      (1..10)        => 80,
      (11.25)        => 60,
      (26..100)      => 40
    },
    :h1b_bw_atp_amt  => {
      0              => 100,
      (1..10)        => 80,
      (11..25)       => 60,
      (26.100)       => 40
    },
    :h1b_ee_atp_cnt  => {
      0              => 100,
      (1..10000)     => 80,
      (10001..50000) => 60,
      (50001..15000) => 40
    },
    :h1b_cmp_assd_amt => {
      0              => 100,
      (1..1000)      => 80,
      (1001..10000)  => 60,
      (10001..50000) => 40
    }
  }

  def calculate_rating
    child_labor_avg = (flsa_cl_violtn_count_grade + flsa_cl_minor_count_grade + flsa_cl_cmp_assd_amt_grade)/3

    mspa_avg = (mspa_violtn_cnt_grade + mspa_bw_atp_amt_grade + mspa_ee_atp_cnt_grade + mspa_cmp_assd_amt_grade)/4

    fmla_avg = (fmla_violtn_cnt_grade + fmla_bw_atp_amt_grade + fmla_ee_atp_cnt_grade)/3

    h1b_avg = (h1b_violtn_cnt_grade + h1b_bw_atp_amt_grade + h1b_ee_atp_cnt_grade + h1b_cmp_assd_amt_grade)/4

    total = child_labor_avg + (flsa_repeat_violator_grade * 2 )+ flsa_violation_count_grade + flsa_ee_atp_count_grade +
            bw_atp_amt_grade + mspa_avg + fmla_avg + h1b_avg
    grade = total / 9
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
