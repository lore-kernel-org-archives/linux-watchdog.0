Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:44852 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932932AbcIUUSn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Sep 2016 16:18:43 -0400
Date: Wed, 21 Sep 2016 14:18:40 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: tomas.winkler@intel.com, tglx@linutronix.de, clemens@ladisch.de,
        wim@iguana.be, linux@roeck-us.net, davem@davemloft.net,
        geert@linux-m68k.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, kvalo@codeaurora.org,
        mchehab@kernel.org, ghackmann@google.com, ben@decadent.org.uk,
        maheshkhanwalkar@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Move runnable examples code from Documentation
 to samples
Message-ID: <20160921141840.229886ea@lwn.net>
In-Reply-To: <cover.1474485474.git.shuahkh@osg.samsung.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Sep 2016 13:47:29 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move runnable examples code from Documentation to samples. I moved
> just the example code, and left documentation files as is.
>=20
> I dropped accounting, laptops, and pcmcia from this v2 series as per
> the v1 feedback on these being a better fit under tools. I will send
> a separate v2 for them.
>=20
> If v2 patches look good, and if I get an okay, I will try to get these
> into 4.9-rc1
>=20
> Changes since v1:
> - Updated location information in .txt for timers, watchdog, and
>   auxdisplay
> - Updated MAINTAINERS file for misc-devices/mei based on feedback
>   from Tomas Winkler
> - Added Acked-by from Jon Corbet for timers, and misc-devices/mei

Looks good, feel free to add my ack to the rest.

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
