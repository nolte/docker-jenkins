
import hudson.markup.RawHtmlMarkupFormatter
import jenkins.model.*

def instance = Jenkins.getInstance()


instance.setMarkupFormatter(new RawHtmlMarkupFormatter(false))
instance.save()

println 'Markup formatter configured.'
