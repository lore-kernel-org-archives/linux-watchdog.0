Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53417 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932408AbbEVNhj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 09:37:39 -0400
Message-ID: <555F311E.8090404@roeck-us.net>
Date: Fri, 22 May 2015 06:37:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-6-git-send-email-fu.wei@linaro.org>	<555ECD04.6000404@offcode.fi>	<CADyBb7sZWgNnEoTfaYm6=YcbWgEYRMcaNAdX9Y7B6W9pg+gOmg@mail.gmail.com>	<555EEFDB.2030907@offcode.fi> <CADyBb7uh-6=ihfrKHBVXDzAKAE-_GqLXTPJa5_7Gw2R71pyeUg@mail.gmail.com> <555F1D91.3020506@offcode.fi>
In-Reply-To: <555F1D91.3020506@offcode.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2015 05:14 AM, Timo Kokkonen wrote:
[ ... ]

> This is the direction we could go eventually. Of course not all features are in interest for everyone and it may not make sense to try implement everything in the core. But we have a lot of drivers that implement all sorts of timers in them and my patch set could eliminate a lot of code from them. We also have couple of drivers that have pretimeout support and there seems to be a desire make that generic as well. Obviously I think it makes sense to combine this effort in order to avoid conflicts.
>
I would suggest to avoid trying to combine efforts. If anything, I would suggest
to _separate_ patch sets.

> So I am too hoping more guidelines on what is the acceptable direction where to aim at. For example we could make this parameter handling more generic and future proof if we allow an API change that require small change to all drivers. I don't know exactly where the line is drawn.
>
As I just mentioned separately, the more changes you make, the less likely
it will be to get your changes accepted. A patch set requiring changes to
all drivers would have to provide substantial benefits to get accepted.
Talking about parameters (and assuming you mean module parameters), I don't
even see how you could make that work without changing the userspace ABI,
which would be a no-go.

Personally I think it would be easier if you tried to accomplish less
than more. Concentrate on early-timeout (only), get it merged. Provide
a clear separation between is_active (as in "watchdog running") from
is_open (userspace has the driver open) and get it merged. Add the
ability to "ping" a running watchdog while the driver is closed
into the watchdog core and get it merged. Add the ability to soft-ping
a watchdog while the driver is open into the core and get it merged.
Those are all logically separate functions, and could be introduced
separately.

Just my personal opinion, of course.

Thanks,
Guenter

