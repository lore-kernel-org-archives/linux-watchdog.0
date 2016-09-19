Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:34325 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbcISQKE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 12:10:04 -0400
Date: Mon, 19 Sep 2016 10:10:01 -0600
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
Subject: Re: [PATCH 3/8] samples: move laptops example code from
 Documentation
Message-ID: <20160919101001.22ba10d3@lwn.net>
In-Reply-To: <8029dc678a811fc42a829494c1582f5bdf57f49d.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <8029dc678a811fc42a829494c1582f5bdf57f49d.1474073857.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 19 Sep 2016 08:47:34 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move laptops examples to samples and remove it from Documentation
> Makefile. Create a new Makefile to build laptops. It can be built
> from top level directory or from laptops directory:

This one might be better called a "tool" rather than a "sample" - assuming
it actually still works, of course.  It hasn't seen a real update in the
Git era, which is a bit disconcerting.  Is it possible that this is dead
code that we might want to just get rid of?

If it stays, Documentation/laptops/laptop-mode.txt needs an update.

jon
