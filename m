Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43514 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426Ab3FRQLX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 12:11:23 -0400
Message-ID: <51C086A8.3070601@arm.com>
Date: Tue, 18 Jun 2013 17:11:20 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
References: <cover.1371535241.git.viresh.kumar@linaro.org> <22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org> <20130618154236.GA9022@roeck-us.net>
In-Reply-To: <20130618154236.GA9022@roeck-us.net>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 18/06/13 16:42, Guenter Roeck wrote:
> On Tue, Jun 18, 2013 at 08:50:25PM +0530, Viresh Kumar wrote:
>> This driver was broken since ever.
>>
>> - Interrupt request doesn't use the right API: The TWD watchdog uses a=
 per-cpu
>>   interrupt (usually interrupt #30), and the GIC configuration should =
flag it as
>>   such. With this setup, request_irq() should fail, and the right API =
is
>>   request_percpu_irq(), together with enable_percpu_irq()/disable_perc=
pu_irq().
>>
>> - Nothing ensures the userspace ioctl() will end-up kicking the watchd=
og on the
>>   right CPU.
>>
>> Was last discussed here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/09596=
0.html
>>
>> Lets mark it broken until somebody with this hardware gets up and fixe=
s it.
>>
> I must be missing something. What is the point of the remaining patches=
 in this
> case ?

Indeed. This looks like pointless churn to me, unless someone actually
picks up the driver and fixes it for good.

If nobody cares enough about it, then maybe it should be moved into
staging and eventually retired...

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
