Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41388 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbcBDFRf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 00:17:35 -0500
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
To: Fu Wei <fu.wei@linaro.org>, Timur Tabi <timur@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56B2DEE4.7060901@roeck-us.net>
Date: Wed, 3 Feb 2016 21:17:24 -0800
MIME-Version: 1.0
In-Reply-To: <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/03/2016 03:00 PM, Fu Wei wrote:
> On 4 February 2016 at 02:45, Timur Tabi <timur@codeaurora.org> wrote:
>> Fu Wei wrote:
>>>
>>> As you know I have made the pre-timeout support patch, If people like
>>> it, i am happy to go on upstream it separately.
>>>
>>> If we want to use pre-timeout here, user only can use get_pretimeout
>>> and disable panic by setting pretimeout to 0
>>> but user can not really set pretimeout, because "pre-timeout  ==
>>> timeout / 2 (always)".
>>> if user want to change pretimeout, he/she has to set_time instead.
>>
>>
>> Ok, I think patches 4 and 5 should be combined, and I think the Kconfig
>> entry should be removed and just use panic_enabled.

Agreed.
>
> NP, will update this patchset like that ,  thanks :-)
>

Also, if panic is enabled, the timeout needs to be adjusted accordingly
(to only panic after the entire timeout period has expired, not after
half of it). We can not panic the system after timeout / 2.

I am not too happy with the parameter name (panic_enabled). How about
"action", to match machzwd ?

Thanks,
Guenter

