Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51352 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaJADap (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Sep 2014 23:30:45 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XZAcm-002aXw-MM
	for linux-watchdog@vger.kernel.org; Wed, 01 Oct 2014 03:30:44 +0000
Message-ID: <542B74F5.1080102@roeck-us.net>
Date: Tue, 30 Sep 2014 20:28:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Tomasz Figa <t.figa@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v7 00/11] kernel: Add support for restart handler call
 chain
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>	<20140930142002.e09ef32392a2b5a7c81e5e57@linux-foundation.org>	<20140930223000.GA20946@roeck-us.net> <20141001094001.2b85f54c@canb.auug.org.au>
In-Reply-To: <20141001094001.2b85f54c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/30/2014 04:40 PM, Stephen Rothwell wrote:
> Hi Guenter,
>
> On Tue, 30 Sep 2014 15:30:00 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, Sep 30, 2014 at 02:20:02PM -0700, Andrew Morton wrote:
>>> On Tue, 19 Aug 2014 17:45:27 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> Introduce a system restart handler call chain to solve the described problems.
>>>
>>> So someone has merged eight of these patches into linux-next but these
>>> three:
>>>
>>> watchdog-s3c2410-add-restart-handler.patch
>>> clk-samsung-register-restart-handlers-for-s3c2412-and-s3c2443.patch
>>> clk-rockchip-add-restart-handler.patch
>>>
>>> were omitted.  What's up?
>>
>> Most likely PBKC on my side; Looks like I forgot to add those when I created
>> the immutable branch for others to merge. Sorry for that :-(.
>>
>> Having said that, I somehow thought that the clock patches would go in through
>> the clock tree. Heiko, did I get that wrong ? Separately, I sent a pull request
>> that includes the watchdog patch to Wim.
>
> So far, that immutable branch has been merged into the battery tree
> (and thus into linux-next) by Sebastian in order to add (I assume):
>
> 18a702e0de98 power: reset: use restart_notifier mechanism for msm-poweroff
> 371bb20d6927 power: Add simple gpio-restart driver
>
> on top of it.
>
> So, I guess the watchdog and clk trees also need to merge that
> immutable branch and then add their respective patches from the mmotm
> series to their trees.
>
Yes, and now I remember why I did not include those patches: They are not
authored by myself. I thought it was not appropriate for me to include them
in the branch I created. Maybe flawed thinking, but that was my reasoning.

Guenter

