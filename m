Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:34237 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752045AbcISQCX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 12:02:23 -0400
Date: Mon, 19 Sep 2016 10:02:20 -0600
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
Subject: Re: [PATCH 1/8] samples: move accounting example code from
 Documentation
Message-ID: <20160919100220.3581d122@lwn.net>
In-Reply-To: <a73182df44d0827ed6338c082a8ea16d6d2bd0b8.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <a73182df44d0827ed6338c082a8ea16d6d2bd0b8.1474073857.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 19 Sep 2016 08:47:32 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move accounting examples to samples and remove it from Documentation
> Makefile. Create a new Makefile to build accounting. It can be built
> from top level directory or from accounting directory:

So I like the basic idea of these patches; it's the direction we've been
trying to push things for a little bit.  I have a couple of specific
comments for this one that may well apply to the others as well.

1) Is samples the right destination for these utilities?  Some of them
   might well be better placed under tools/ instead.  I'm not sure we've
   ever formally stated the purpose of those two subtrees; I see samples/
   as demonstrations of how to use something, while tools/ are utilities
   you might actually want to use for some purpose.  Something like
   getdelays might well fall into the latter group.  But maybe others
   disagree?

2) Tools like getdelays are referenced in the documents that have been
   left behind; see accounting/delay-accounting.txt, for example.  Those
   documents should be updated so that readers know where to find the
   referenced programs, wherever they end up.  Converting them to Sphinx
   while you're at it is an extra-credit exercise :)

Thanks,

jon
