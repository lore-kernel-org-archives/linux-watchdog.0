Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:34380 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbcISQRA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 12:17:00 -0400
Date: Mon, 19 Sep 2016 10:16:57 -0600
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
Subject: Re: [PATCH 6/8] samples: move pcmcia example code from
 Documentation
Message-ID: <20160919101657.05ca0144@lwn.net>
In-Reply-To: <2a7ba074ee6bba6d3f7b049dd993e4bf4ecb6544.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <2a7ba074ee6bba6d3f7b049dd993e4bf4ecb6544.1474073857.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Sep 2016 08:47:37 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move pcmcia examples to samples and remove it from Documentation
> Makefile. Create a new Makefile to build pcmcia. It can be built
> from top level directory or from pcmcia directory:

Does PCMCIA still exist/work?  I guess it probably must somewhere.  This
one might better qualify as a "tool."
Documentation/pcmcia/devicetable.txt needs an update, as does MAINTAINERS=
.

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
