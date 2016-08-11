Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35020 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcHKKP7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Aug 2016 06:15:59 -0400
Received: by mail-pf0-f169.google.com with SMTP id x72so25486050pfd.2
        for <linux-watchdog@vger.kernel.org>; Thu, 11 Aug 2016 03:15:58 -0700 (PDT)
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Tomasz Nowicki <tn@semihalf.com>, fu.wei@linaro.org,
	lorenzo.pieralisi@arm.com
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
Date: Thu, 11 Aug 2016 18:15:50 +0800
MIME-Version: 1.0
In-Reply-To: <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 2016/8/11 17:37, Tomasz Nowicki wrote:
> Hi Fu,
>
> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
> would be introduced in first place ? This means your GTDT set would
> depend on IORT.

I think it's reasonable as the IORT for ITS is the key device enablement
for PCI MSI. I talked to Fuwei offline and he is fine with it.

But both the GTDT patchset and IORT are in good shape now, can we
targeting both of them for 4.9 kernel (since all go via tip tree)?

Thanks
Hanjun
