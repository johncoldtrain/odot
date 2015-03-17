class FoundationFormBuilder < ActionView::Helpers::FormBuilder
	include ActionView::Helpers::TagHelper
	include ActionView::Helpers::CaptureHelper
	include ActionView::Helpers::TextHelper

	attr_accessor :output_buffer


#-----------------------------------------------------------------------------------------------
	# def text_field(attribute, options={})
	# 	options[:label] ||= attribute # by default if no label is passed, it takes the attribute
	# 	label_text ||= options.delete(:label).to_s.titleize #remove label option from the hash before passing it to super. Also formating it
	# 	#initialize hashes
	# 	label_options ||= {}
	# 	wrapper_options ||= {}

	# 	# Send error class to wrapper as options hash if there is an error present in the object
	# 	wrapper_options = { wrapper_classes: "error" } if errors_on?(attribute)

	# 	wrapper(wrapper_options) do 
	# 		label(attribute, label_text, label_options) +
	# 		super(attribute, options) + errors_for_field(attribute) # Inserts the error <small> 
	# 	end
	# end 
#--------------------------Replaced by metaprogramming below -----------------------------------

#### BECAUSE THE SAME FIELD FORMATING CODE IS USED FOR SEVERAL FIELDS (text_field, email_field, passowrd_field)
#### HERE WE USE METAPROGRAMMING TO LOOP THROUGH THE ARRAY OF 3 STRINGS, THEN USING THE METHOD "define_method"
#### AND PASSING THE ARGUMENTS, 3 METHODS ARE CREATED FOR EACH FIELD TYPE IN THE ARRAY

	%w(text_field email_field password_field).each do |form_method|
		define_method(form_method) do |*args|
			attribute = args[0]
			options = args[1] || {}
			# --- Start of old method ---
			options[:label] ||= attribute.to_s.titleize # by default if no label is passed, it takes the attribute
			label_text ||= options.delete(:label) #remove label option from the hash before passing it to super. 
			# - initialize hashes -
			label_options ||= {}
			wrapper_options ||= {}

			# - Send error class to wrapper as options hash if there is an error present in the object -
			wrapper_options = { wrapper_classes: "error" } if errors_on?(attribute)

			wrapper(wrapper_options) do 
				label(attribute, label_text, label_options) +
				super(attribute, options) + errors_for_field(attribute) # Inserts the error <small> 
			end
		end
	end #array.each (metaprogramming)





#-----------------------------------------------------------------------------------------------
	def submit(text, options={})
		options[:class] ||= "button radius expand"
		wrapper do 
			super(text, options)
		end
	end 
#-----------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------
	def errors_for_field(attribute, options={})
		return "" if object.errors[attribute].empty?
		content_tag(:small, object.errors[attribute].to_sentence.capitalize, class: "error")
	end
#-----------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------
# Checks if there is an error in the object
	def errors_on?(attribute)
		object.errors[attribute].size > 0
	end
#-----------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------
	def wrapper(options={}, &block)
		content_tag(:div, class: "row") do
			content_tag(:div, capture(&block), class: "small-12 columns #{options[:wrapper_classes]}") 
			# inserts the text from the &block with "capture", variable options for error to be inserted with
			# wrapper_classes option
		end
	end
#-----------------------------------------------------------------------------------------------
 ############## In order to DRY the code, a wrapper method is created above ################
#### This is how the submit method looked like before the wrapper method was implemented ####

	# def submit(text, options={})
	# 	options[:class] ||= "button radius expand"

	# 	content_tag(:div, class: "row") do
	# 		content_tag(:div, class: "small-12 columns")
	# 			super(text, options)
	# 	end
	# end # submit





end