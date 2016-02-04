Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57519 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713AbcBDOll (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 09:41:41 -0500
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
To: Timur Tabi <timur@codeaurora.org>, Fu Wei <fu.wei@linaro.org>
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
 <56B2DEE4.7060901@roeck-us.net> <56B35698.4020100@codeaurora.org>
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
Message-ID: <56B3631F.6090304@roeck-us.net>
Date: Thu, 4 Feb 2016 06:41:35 -0800
MIME-Version: 1.0
In-Reply-To: <56B35698.4020100@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/04/2016 05:48 AM, Timur Tabi wrote:
> Guenter Roeck wrote:
>> Also, if panic is enabled, the timeout needs to be adjusted accordingly
>> (to only panic after the entire timeout period has expired, not after
>> half of it). We can not panic the system after timeout / 2.
>
> It's a debugging feature, not an actual watchdog timeout panic.  That's why it's disabled by default.
>

"* When the first stage(the half timeout) is reached, WS0 interrupt is
  * triggered, at this moment the second watch period starts;
  * In the WS0 interrupt routine, panic will be triggered for saving the
  * system context.
  * If the system is getting into trouble and cannot be reset by panic or
  * restart properly by the kdump kernel(if supported), then the second
  * stage (the timeout) will be reached, system will be reset by WS1."

That doesn't sound like debugging to me.

Guenter

