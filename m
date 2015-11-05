Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42901 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161471AbbKEOI7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 09:08:59 -0500
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Fu Wei <fu.wei@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>,
	Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Dave Young <dyoung@redhat.com>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
 <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
 <563AE588.1080009@roeck-us.net> <563B5DF9.6080102@codeaurora.org>
 <CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <563B62F7.3050307@codeaurora.org>
Date: Thu, 5 Nov 2015 08:08:55 -0600
MIME-Version: 1.0
In-Reply-To: <CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
> SBSA 2.3 Page 23 :
> Note: the watchdog offset register is 32 bits wide. This gives a
> maximum watch period of around 10s at a system
> counter frequency of 400MHz. If a larger watch period is required then
> the compare value can be programmed
> directly into the compare value register.
>
> 214s means your system counter is approximately at 20MHz which is in
> the range of (10MHz ~ 400MHz)
>
> SBSA 2.3 Page 13 :
> The System Counter (of the Generic Timer) shall run at a minimum
> frequency of 10MHz and maximum of
> 400MHz.

Thanks, that explains a lot.

If we expected customers to have a lower system counter frequency, then 
we wouldn't have to worry about the timeouts being too short.  It seems 
to me that the SBSA spec says that if you want a longer timeout, you 
have to lower the frequency.  We shouldn't be complicating the driver 
because some customers might not follow the spec.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
