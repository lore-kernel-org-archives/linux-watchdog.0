Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43462 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab2CGM1A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:27:00 -0500
Received: by wejx9 with SMTP id x9so3737821wej.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 04:26:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307103414.GA2568@pengutronix.de>
References: <cover.1331115751.git.viresh.kumar@st.com>
	<20120307103414.GA2568@pengutronix.de>
Date: Wed, 7 Mar 2012 04:26:58 -0800
Message-ID: <CAOh2x=n6Xx0r7OsTvYTY9d6V11WgGuruF9D3kGVb8DosqAtatw@mail.gmail.com>
Subject: Re: [PATCH 00/15] watchdog/mpcore: updates & fixes
From: viresh kumar <viresh.linux@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org, spear-devel@list.st.com,
	linux-arm-kernel@lists.infradead.org,
	srinidhi.kasagar@stericsson.com, linus.walleij@stericsson.com,
	alan@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 3/7/12, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> This patchset contains fixes and updates for ARM mpcore watchdog driver.
>
> It probably makes sense to convert this to use the watchdog-core. See
> Documentation/watchdog/convert_drivers_to_kernel_api.txt for some
> guidance.
>

Sorry for not checking that earlier.
Will align my patchset to that.

--
viresh
