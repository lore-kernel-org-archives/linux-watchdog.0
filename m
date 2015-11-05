Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41270 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161373AbbKENrk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 08:47:40 -0500
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Guenter Roeck <linux@roeck-us.net>, Fu Wei <fu.wei@linaro.org>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
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
 <563AE588.1080009@roeck-us.net>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <563B5DF9.6080102@codeaurora.org>
Date: Thu, 5 Nov 2015 07:47:37 -0600
MIME-Version: 1.0
In-Reply-To: <563AE588.1080009@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck wrote:
> I would feel much more comfortable if the driver would just use the
> standard
> watchdog timeout and live with (worst case) 20 seconds timeout for now.

Actually, I'm wondering where the 20 seconds comes from.  When I load my 
driver on our hardware, it calculates a maximum timeout of 214 seconds, 
and that's just to WS0.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
