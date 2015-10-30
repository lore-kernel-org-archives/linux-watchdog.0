Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40310 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759863AbbJ3Sx2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 14:53:28 -0400
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
To: Fu Wei <fu.wei@linaro.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-2-git-send-email-fu.wei@linaro.org>
 <20151027162257.GJ3091@leverpostej>
 <CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
 <CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
 <CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com>
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
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <5633BCA4.1050400@codeaurora.org>
Date: Fri, 30 Oct 2015 13:53:24 -0500
MIME-Version: 1.0
In-Reply-To: <CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/30/2015 01:35 PM, Fu Wei wrote:
>> I think maybe Mark was asking why WS1 is optional, not the WS1
> My answer is for "why WS1 is optional"!
>
>> >interrupt.  Maybe you can reword the documentation to make is clear
>> >that
> I didn't say : "only the*interrupt*  for WS1 is optional."

WS1 itself is not optional.  The spec says that WS0 and WS1 are separate 
events, and doesn't saying anything about either being optional.  The 
*interrupt* for WS1, however, is optional.

Besides, what does the driver do with the WS1 interrupt?  If it's 
specified in the device tree, it appears to be ignored by the driver. 
And the ACPI table only allows for specifying ONE interrupt.  So how 
would the driver register a handler for WS1 on an ACPI system?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
