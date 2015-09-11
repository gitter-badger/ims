class Value < ActiveRecord::Base

  belongs_to :device
  belongs_to :property

  validates :value , presence: true
  validates :property_id , presence: true


  def getConvertedValue
    typ =self.property.data_type.name

    if typ == "String"
      return self.value
    elsif typ == "Fixnum"
      return self.value.to_i
    elsif typ == "Time"
      return Time.parse(self.value)
    elsif typ =="Boolean"
      return true if self.value=="true"
      return false if self.value=="false"
    elsif typ == "Float"
      return self.value.to_f
    end
  end

  def setConvertedValue(v)

    typ = self.property.data_type.name

    if typ=="String"
    self.value=v

#TODO: Check data types
    elsif typ=="Integer"
      self.value=v

    elsif typ=="Float"
      self.value=v

    elsif typ=="Boolean"
      if v=="on"
        self.value="true"
      end


    elsif typ=="Time"
      self.value=Time.parse(v).to_s

    else
       #flash[:ERROR] =self.property.name + " is " + v.class + " not " + @typ
    end

  end

  def self.fill


    dt = Value.new
    #dt.value = "Test String"
    dt.property = Property.find_by_name("Property1")
    dt.device = Device.find_by_info("Info1")
    dt.setConvertedValue("Test String")


    dt = Value.new
    #dt.value = true
    dt.property = Property.find_by_name("Property2")
    dt.device = Device.find_by_info("Info2")
    dt.setConvertedValue(true)


    dt = Value.new
    #dt.value = 3
    dt.property = Property.find_by_name("Property3")
    dt.device = Device.find_by_info("Info2")
    dt.setConvertedValue(3)


    dt = Value.new
    #dt.value = 3.14
    dt.property = Property.find_by_name("Property4")
    dt.device = Device.find_by_info("Info2")
    dt.setConvertedValue(3.14)

  end


end
