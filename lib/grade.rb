module Grade

  def calculate_rating
    child_labor_avg = (child_labor_count_rating + child_labor_minor_count_rating + child_labor_penalty_rating)/3

    mspa_avg = (mspa_violtn_cnt_rating + mspa_bw_atp_amt_rating + mspa_ee_atp_cnt_rating + mspa_cmp_assd_amt_rating)/4

    fmla_avg = (fmla_violtn_cnt_rating + fmla_bw_atp_amt_rating + fmla_ee_atp_cnt_rating)/3

    h1b_avg = (h1b_violtn_cnt_rating + h1b_bw_atp_amt_rating + h1b_ee_atp_cnt_rating + h1b_cmp_assd_amt_rating)/4

    total = child_labor_avg + (flsa_repeat_violator_rating * 2 )+ flsa_violation_count_rating + flsa_ee_atp_count_rating +
            bw_atp_amt_rating + mspa_avg + fmla_avg + h1b_avg
    grade = total / 9
  end

  def assign_letter_grade
    case calculate_rating
      when 5
        "A"
      when 4
        "B"
      when 3
        "C"
      when 2
        "D"
      when 1
        "F"
    end
  end

private

  def child_labor_count_rating
    case self.flsa_cl_violtn_count
      when 0
        5
      when 1
        4
      when (2..10)
        3
      when (11..50)
        2
      else
        1
    end
  end

  def child_labor_minor_count_rating
    case self.flsa_cl_minor_count
      when 0
        5
      when 1
        3
      else
        1
    end
  end

  def child_labor_penalty_rating
    case self.flsa_cl_cmp_assd_amt
      when 0
        5
      when (1..2000)
        4
      when (2001..5000)
        3
      when (5001..15000)
        2
      else
        1
    end
  end

  def flsa_repeat_violator_rating
    case self.flsa_repeat_violator
      when "N/A"
        5
      when "R"
        2
      when "RW"
        1
      else
        5
    end
  end

  def flsa_violation_count_rating
    case self.flsa_violation_count
      when 0
        5
      when (1..50)
        4
      when (51..150)
        3
      when (151..300)
        2
      else
        1
    end
  end

  def flsa_ee_atp_count_rating
    case self.flsa_ee_atp_count
      when 0
        5
      when (1..50)
        4
      when (51..150)
        3
      when (151..300)
        2
      else
        1
    end
  end

  def bw_atp_amt_rating
    case self.bw_atp_amt
      when 0
        5
      when (1..500)
        4
      when (501..5000)
        3
      when (5001..50000)
        2
      else
        1
    end
  end

  def mspa_violtn_cnt_rating
    case self.mspa_violtn_cnt
      when 0
        5
      when (1..5)
        3
      else
        1
    end
  end

  def mspa_bw_atp_amt_rating
    case self.mspa_bw_atp_amt
      when 0
        5
      when (1..2000)
        4
      when (2001..10000)
        3
      when (10001..25000)
        2
      else
        1
    end
  end

  def mspa_ee_atp_cnt_rating
    case self.mspa_ee_atp_cnt
      when 0
        5
      when (1..20)
        4
      when (21..100)
        3
      when (101..200)
        2
      else
        1
    end
  end

  def mspa_cmp_assd_amt_rating
    case self.mspa_cmp_assd_amt
      when 0
        5
      when (1..500)
        4
      when (501..2000)
        3
      when (2001..7500)
        2
      else
        1
    end
  end

  def fmla_violtn_cnt_rating
    case self.fmla_violtn_cnt
      when 0
        5
      when (1..10)
        4
      when (11..100)
        3
      when (101..1000)
        2
      else
        1
    end
  end

  def fmla_bw_atp_amt_rating
    case self.fmla_bw_atp_amt
      when 0
        5
      when (1..10)
        4
      when (11..100)
        3
      when (101..1000)
        2
      else
        1
    end
  end

  def fmla_ee_atp_cnt_rating
    case self.fmla_bw_atp_amt
      when 0
        5
      when (1)
        4
      when (2..5)
        3
      when (6..25)
        2
      else
        1
    end
  end

  #All entries are 0?
  def fmla_cmp_assd_amt_rating
    case fmla_cmp_assd_amt
      when 0
        5
      else
        1
    end
  end

  def h1b_violtn_cnt_rating
    case h1b_violtn_cnt
      when 0
        5
      when 1..10
        4
      when 11.25
        3
      when 26..100
        2
      else
        1
    end
  end

  def h1b_bw_atp_amt_rating
    case h1b_bw_atp_amt
      when 0
        5
      when 1..10
        4
      when 11.25
        3
      when 26..100
        2
      else
        1
    end
  end

  def h1b_ee_atp_cnt_rating
    case h1b_ee_atp_cnt
      when 0
        5
      when 1..10000
        4
      when 10001..50000
        3
      when 50000..150000
        2
      else
        1
    end
  end

  def h1b_cmp_assd_amt_rating
    case h1b_ee_atp_cnt
      when 0
        5
      when 1..1000
        4
      when 1001..10000
        3
      when 10001..50000
        2
      else
        1
    end
  end

end
