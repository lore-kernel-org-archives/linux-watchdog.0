Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbcIUTwC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Sep 2016 15:52:02 -0400
Date: Wed, 21 Sep 2016 21:52:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: corbet@lwn.net, tomas.winkler@intel.com, tglx@linutronix.de,
        clemens@ladisch.de, wim@iguana.be, linux@roeck-us.net,
        davem@davemloft.net, geert@linux-m68k.org,
        akpm@linux-foundation.org, kvalo@codeaurora.org,
        mchehab@kernel.org, ghackmann@google.com, ben@decadent.org.uk,
        maheshkhanwalkar@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/4] samples: move misc-devices/mei example code from
 Documentation
Message-ID: <20160921195206.GA24364@kroah.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
 <5db171353261e2b20ebc78855057792a5a633699.1474485474.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db171353261e2b20ebc78855057792a5a633699.1474485474.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 21, 2016 at 01:47:30PM -0600, Shuah Khan wrote:
> Move misc-devices/mei examples to samples/mei and remove it from
> Documentation Makefile. Delete misc-devices/Makefile.
> 
> Create a new Makefile to build samples/mei. It can be built from top
> level directory or from mei directory:
> 
> Run make -C samples/mei or cd samples/mei; make
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
