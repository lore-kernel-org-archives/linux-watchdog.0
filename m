Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40938 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbbEOR7E (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 13:59:04 -0400
Date: Fri, 15 May 2015 10:59:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: Fu Wei <fu.wei@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
Message-ID: <20150515175900.GA19230@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1431689090-3125-1-git-send-email-fu.wei@linaro.org>
 <5555F5C5.8050806@roeck-us.net>
 <CADyBb7sC5a6vC6CqQsfCqOaxz1P8gKNkZi5qEHtXL7efv42-=Q@mail.gmail.com>
 <5555FACD.6000408@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5555FACD.6000408@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 15, 2015 at 08:55:25AM -0500, Timur Tabi wrote:
> Fu Wei wrote:
> >>>The new API function also needs to be documented in
> >>>Documentation/watchdog/watchdog-kernel-api.txt.
> >good point, thanks will do
> 
> Yes, please, since my driver does not use or need any pre-timeout support,
> so I don't understand why this patch exists.  What is pre-timeout anyway?

Documentation/watchdog/watchdog-api.txt; look for "Pretimeouts:".

Guenter
