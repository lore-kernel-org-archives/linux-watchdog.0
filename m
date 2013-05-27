Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:48236 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752281Ab3E0FnU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 May 2013 01:43:20 -0400
Date: Mon, 27 May 2013 07:43:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/5] watchdog: ts72xx: Remove redundant platform_set_drvdata()
Message-ID: <20130527054318.GD14155@spo001.leaseweb.com>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org> <1367611878-3784-4-git-send-email-sachin.kamat@linaro.org> <CALp=xyPyWrjB6+6tjCM5owusHUgu2Ps3q6UjhFUd8RzSNoY+MQ@mail.gmail.com> <CAK9yfHwNikbaMa2z2D0xJWQU3U-kgyb2X-+K+uHxrMzucPmeww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9yfHwNikbaMa2z2D0xJWQU3U-kgyb2X-+K+uHxrMzucPmeww@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> On 6 May 2013 12:32, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> > On Fri, May 3, 2013 at 11:11 PM, Sachin Kamat <sachin.kamat@linaro.org>
> > wrote:
> >>
> >> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> >> driver is bound) removes the need to set driver data field to
> >> NULL.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> >
> >
> > Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
> >
> 
> Looks like you missed this patch.

Not really, It was allready covered in Jingoo's patch so there
was no need to do this anymore.

Kind regards,
Wim.

