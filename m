Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53847 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbaE0Xex (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 May 2014 19:34:53 -0400
Message-ID: <5385210F.4030205@roeck-us.net>
Date: Tue, 27 May 2014 16:34:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: David Cohen <david.a.cohen@linux.intel.com>, wim@iguana.be,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] x86: intel-mid: fix watchdog platform code
References: <1401225066-28786-1-git-send-email-david.a.cohen@intel.com> <1401225670-28959-1-git-send-email-david.a.cohen@linux.intel.com>
In-Reply-To: <1401225670-28959-1-git-send-email-david.a.cohen@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/27/2014 02:21 PM, David Cohen wrote:
> This patch fixes missing include asm/io_apic.h which may lead to
> following error:
>
>     arch/x86/platform/intel-mid/device_libs/platform_wdt.c: In function 'tangier_probe':
>>> arch/x86/platform/intel-mid/device_libs/platform_wdt.c:37:2: error: implicit declaration of function 'mp_find_ioapic' [-Werror=implicit-function-declaration]
>       ioapic = mp_find_ioapic(irq);
>       ^
>>> arch/x86/platform/intel-mid/device_libs/platform_wdt.c:44:3: error: implicit declaration of function 'io_apic_set_pci_routing' [-Werror=implicit-function-declaration]
>        ret = io_apic_set_pci_routing(NULL, irq, &irq_attr);
>        ^
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

