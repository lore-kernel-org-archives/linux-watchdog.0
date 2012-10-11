Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63644 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534Ab2JKL4I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Oct 2012 07:56:08 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1583565oag.19
        for <linux-watchdog@vger.kernel.org>; Thu, 11 Oct 2012 04:56:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5075865C.3010606@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
 <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com> <5075865C.3010606@gmail.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 11 Oct 2012 13:55:47 +0200
Message-ID: <CAHkwnC9B7e-3bqar5ePmXQ9eNUnEAsnf+8mdjSKDshAHVQet6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt: add helper inline for retrieving timeout-sec property
To: Rob Herring <robherring2@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 10, 2012 at 4:29 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 10/09/2012 07:04 AM, Fabio Porcedda wrote:
>> The first user of this function is the watchdog framework.
>
> Who is the 2nd user because I don't see any others. I don't see this
> being a widely used property.

Hi Rob, thanks for reviewing.

There is only one use of this function in my patchset.
I added this function after Jean-Christophe repeatedly suggested to add it.

On Fri, Oct 5, 2012 at 1:16 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> why I bother to comment
> *make this of generic* this is not watchdog specific other driver can use it

Maybe the idea was to have the helper ready when the dt support it's
added to a drivers that use a "timeout" parameter.

If it's for better i can just get rid of this function.
I don't mind.

Best regards

>
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  include/linux/of.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 72843b7..5870818 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -470,4 +470,15 @@ static inline int of_property_read_u32(const struct device_node *np,
>>       return of_property_read_u32_array(np, propname, out_value, 1);
>>  }
>>
>> +/**
>> + * of_get_timeout_sec() - Helper to read the timeout_sec property
>> + * @np:              device node from which the property value is to be read.
>> + * @timeout: adress of the output value
>> + */
>> +static inline int of_get_timeout_sec(const struct device_node *np,
>> +                                  u32 *timeout)
>> +{
>> +     return of_property_read_u32(np, "timeout-sec", timeout);
>> +}
>> +
>>  #endif /* _LINUX_OF_H */
>>
>

-- 
Fabio Porcedda
