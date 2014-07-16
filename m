Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56162 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbaGPN2d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Jul 2014 09:28:33 -0400
Message-ID: <53C67DFF.5010008@roeck-us.net>
Date: Wed, 16 Jul 2014 06:28:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>
Subject: Re: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
References: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com> <20140610192619.GD7773@roeck-us.net> <f79bb471224b4b54bce631818b3a802b@BY2PR0301MB0613.namprd03.prod.outlook.com>
In-Reply-To: <f79bb471224b4b54bce631818b3a802b@BY2PR0301MB0613.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/14/2014 07:15 PM, Li.Xiubo@freescale.com wrote:
> Hi,
>
> I'd like to know the status of this patch series.
>
I reviewed it, and it is in my watchdog-next branch, so it is quite likely
that Wim is going to pick it up for the next kernel.

Guenter


> :)
>
> Thanks,
>
> BRs
> Xiubo
>
>
>
>
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
>> Sent: Wednesday, June 11, 2014 3:26 AM
>> To: Xiubo Li-B47053
>> Cc: wim@iguana.be; linux-watchdog@vger.kernel.org; robh+dt@kernel.org;
>> pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk;
>> galak@codeaurora.org
>> Subject: Re: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
>>
>> On Tue, Jun 03, 2014 at 10:45:14AM +0800, Xiubo Li wrote:
>>> This watchdog driver will be working on IMX2+, Vybrid, LS1, LS2+
>>> platforms, and will be in different endianness mode in those SoCs:
>>>
>>>      SoCs       WDT endian mode
>>> ------------------------------------
>>>      IMX2+           LE
>>>      Vybird          LE
>>>      LS1             BE
>>>      LS2             LE
>>>
>>> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

