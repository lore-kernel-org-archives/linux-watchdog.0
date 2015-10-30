Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35441 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbbJ3Rqd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 13:46:33 -0400
MIME-Version: 1.0
In-Reply-To: <CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-2-git-send-email-fu.wei@linaro.org>
	<20151027162257.GJ3091@leverpostej>
	<CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
Date: Fri, 30 Oct 2015 12:46:28 -0500
Message-ID: <CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
From: Timur Tabi <timur@codeaurora.org>
To: Fu Wei <fu.wei@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 27, 2015 at 11:10 PM, Fu Wei <fu.wei@linaro.org> wrote:
>
>> Why is WS1 optional?
>
> According to the description of WS1 in SBSA 2.3 (5.2 Watchdog Operation) page 21
> -----------------
> The signal is fed to a higher agent as an interrupt or reset for it to
> take executive action.
> ----------------
>
> So WS1 maybe a interrupt.
>
> In a real Hardware,  WS1 hooks to a  reset signal pin of BMC, if this
> pin is triggered, BMC will do a real warm reset.
> In this case, WS1 is a reset, Linux doesn't need to deal with that.
>
> For now , I haven't found a hardware use WS1 as  interrupt.
> In <ARM v8-A Foundation Platform User Guide> 3.2 Interrupt maps  Page 22
> Table 3-3 Shared peripheral interrupt assignments
> IRQ ID       SPI offset      Device
> 60               28              EL2 Generic Watchdog WS1
>
> But I don't have further info about it.
>
> Anyway,  because this signal could be interrupt or reset, Linux don't
> need know this signal sometimes.
> So I think it should be optional in binding info.
>
> Do I miss something? Any suggestion ? Please correct me, thanks.

I think maybe Mark was asking why WS1 is optional, not the WS1
interrupt.  Maybe you can reword the documentation to make is clear
that only the *interrupt* for WS1 is optional.

However, the ACPI table only allows for one interrupt, and it's not
clear whether that's the WS0 or WS1 interrupt.  So if both WS0 and WS1
generate an interrupt, how does the driver handle that?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
