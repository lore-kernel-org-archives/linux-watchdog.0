Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbdGNLgM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 07:36:12 -0400
Date: Fri, 14 Jul 2017 13:36:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        Alex Williamson <alex.williamson@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Jakub Sitnicki <jsitnicki@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Travis <travis@sgi.com>,
        Daeseok Youn <daeseok.youn@gmail.com>,
        Huang Rui <ray.huang@amd.com>, Andiry Xu <andiry.xu@amd.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@redhat.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Alexandre Desnoyers <alex@qtec.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wan ZongShun <Vincent.Wan@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <dev@lynxeye.de>,
        Denis Turischev <denis.turischev@compulab.co.il>
Subject: Re: [PATCH 3/5 v4] usb: pci-quirks: Protect the I/O port pair of
 SB800
Message-ID: <20170714113606.GA20265@kroah.com>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
 <20170622132134.7200-4-zboszor@pr.hu>
 <d599eeac-d159-cff6-7140-7b6cce026c7a@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d599eeac-d159-cff6-7140-7b6cce026c7a@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 10:34:20AM +0200, Boszormenyi Zoltan wrote:
> 2017-06-22 15:21 keltez=E9ssel, Zolt=E1n B=F6sz=F6rm=E9nyi =EDrta:
> > This patch uses the previously introduced macro called
> > request_declared_muxed_region() to synchronize access to
> > the I/O port pair 0xcd6 / 0xcd7 on SB800.
> >=20
> > These I/O ports are also used by i2c-piix4 and sp5100_tco,
> > so synchronization is necessary. The other drivers will also
> > be modified to use the new macro in subsequest patched.
> >=20
> > v1: Started with a common mutex in a C source file.
> >=20
> > v2: Declared the common mutex in drivers/usb/host/pci-quirks.c
> >      instead of in a common C file.
> >=20
> > v3: Switched to using the new request_declared_muxed_region
> >      macro.
> >=20
> > v4: Fixed checkpatch.pl warnings and use the new
> >      release_declared_region() macro.
> >=20
> > Signed-off-by: Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>

Why are you responding to your own patches?

You do know this is the middle of the merge window, and we can't do
anything here with patches, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
