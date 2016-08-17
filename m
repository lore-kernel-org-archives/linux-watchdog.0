Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52977 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbcHQTCY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Aug 2016 15:02:24 -0400
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Fu Wei <fu.wei@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
 <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
 <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
 <20160811105848.GA25680@red-moon>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <57B4B47E.5030100@codeaurora.org>
Date: Wed, 17 Aug 2016 14:01:18 -0500
MIME-Version: 1.0
In-Reply-To: <20160811105848.GA25680@red-moon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Lorenzo Pieralisi wrote:
> I do not think you need a v11 just to remove the drivers/acpi/arm64
> directory creation, you need to get Daniel/Thomas review/ack on
> the respective patches though, I do not see the point of churning
> out another series just because drivers/acpi/arm64 is now created
> in the IORT patch series. If v10 is ok you will rebase it on top of
> Tomasz's series and mention the dependency in the respective pull
> request.
>
> If there is need for a v11 following Daniel/Thomas review yes,
> you can proceed as above.

What's the latest on this patchset?  I really want them in 4.9.  Is 
everything queued up, or are still issues that need to be resolved.

Who will be merging these patches?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
