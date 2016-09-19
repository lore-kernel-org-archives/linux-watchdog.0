Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:34393 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbcISQSU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 12:18:20 -0400
Date: Mon, 19 Sep 2016 10:18:18 -0600
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
Subject: Re: [PATCH 7/8] samples: move timers example code from
 Documentation
Message-ID: <20160919101818.3b4bd266@lwn.net>
In-Reply-To: <4c64fb11582db00bd61bd5201dbe160b7be924bf.1474073857.git.shuahkh@osg.samsung.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <4c64fb11582db00bd61bd5201dbe160b7be924bf.1474073857.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 19 Sep 2016 08:47:38 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move timers examples to samples and remove it from Documentation
> Makefile. Create a new Makefile to build timers. It can be built
> from top level directory or from timers directory:

Documentation/timers/hpet.txt needs updating.  Otherwise

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
