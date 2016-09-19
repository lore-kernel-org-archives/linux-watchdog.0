Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:34256 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbcISQGC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 12:06:02 -0400
Date: Mon, 19 Sep 2016 10:05:59 -0600
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
Subject: Re: [PATCH 2/8] samples: move auxdisplay example code from
 Documentation
Message-ID: <20160919100559.65391b6c@lwn.net>
In-Reply-To: <89e4e4ede7eb0c0ae5d72280455115612b0e4c98.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <89e4e4ede7eb0c0ae5d72280455115612b0e4c98.1474073857.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 19 Sep 2016 08:47:33 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move auxdisplay examples to samples and remove it from Documentation
> Makefile. Create a new Makefile to build auxdisplay. It can be built
> from top level directory or from auxdisplay directory:

Documentation/auxdisplay/cfag12864b needs to be updated to reflect the new
home for the program (which probably does belong in samples/).

I wonder if these programs need MAINTAINERS entries too?

jon
