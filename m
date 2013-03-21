Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265Ab3CUSlA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Mar 2013 14:41:00 -0400
Message-ID: <514B5431.8080608@draigBrady.com>
Date: Thu, 21 Mar 2013 18:40:49 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] watchdog: w83627hf: Enable watchdog only once
References: <1362957300-18223-1-git-send-email-linux@roeck-us.net> <1362957300-18223-3-git-send-email-linux@roeck-us.net> <51489FC2.40806@draigBrady.com> <20130319200209.GA16827@roeck-us.net>
In-Reply-To: <20130319200209.GA16827@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 03/19/2013 08:02 PM, Guenter Roeck wrote:
> On Tue, Mar 19, 2013 at 05:26:26PM +0000, P=E1draig Brady wrote:
>> On 03/10/2013 11:14 PM, Guenter Roeck wrote:
>>> It is unnecessary to enable the logical device and WDT0 each time
>>> the watchdog is accessed. Do it only once during initialization.
>>
>> Is this also the case on systems where the superio
>> chip is used for other things? I've the impression
>> that this may break some systems (though I no longer
>> have the hardware to test). Arbitration of multiple
>> users of the superio device may be managed be a central
>> user space app, or by a kernel level arbitrator.
>>
> Not sure if I understand you correctly.
>=20
> You mean some entity might actually disable the watchdog between access=
es
> to it by the watchdog driver ? That would make it pretty useless.
> Might as well turn it off entirely if that is the case.
>=20
> Or do you refer to _selecting_ the hwmon logical device ? If so, this p=
atch
> is about enabling it only once, not about selecting it only once.

I meant selecting.
Enabling only once is fine.

sorry for the noise,

thanks,
P=E1draig.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
