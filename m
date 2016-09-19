Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:34364 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbcISQNv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 12:13:51 -0400
Date: Mon, 19 Sep 2016 10:13:48 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        tomas.winkler@intel.com, tglx@linutronix.de, wim@iguana.be,
        linux@roeck-us.net, elfring@users.sourceforge.net,
        nicolas.dichtel@6wind.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, dasaratharaman.chandramouli@intel.com,
        maheshkhanwalkar@gmail.com, mikedanese@google.com,
        ben@decadent.org.uk, ghackmann@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] samples: move misc-devices/mei example code from
 Documentation
Message-ID: <20160919101348.1eb53045@lwn.net>
In-Reply-To: <12a2016ad44adcfb88f442923411f3345b5b3a1e.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <12a2016ad44adcfb88f442923411f3345b5b3a1e.1474073857.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Sep 2016 08:47:36 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move misc-devices/mei examples to samples/mei and remove it from
> Documentation Makefile. Delete misc-devices/Makefile.
>=20
> Create a new Makefile to build samples/mei. It can be built from top
> level directory or from mei directory:

This one still has a fair amount of code hiding in the .txt files, but
that's a separate job.

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
