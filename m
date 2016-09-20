Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58433
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755381AbcITQLx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Sep 2016 12:11:53 -0400
Subject: Re: [PATCH 3/8] samples: move laptops example code from Documentation
To: Jonathan Corbet <corbet@lwn.net>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
 <8029dc678a811fc42a829494c1582f5bdf57f49d.1474073857.git.shuahkh@osg.samsung.com>
 <20160919101001.22ba10d3@lwn.net>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        tomas.winkler@intel.com, tglx@linutronix.de, wim@iguana.be,
        linux@roeck-us.net, elfring@users.sourceforge.net,
        nicolas.dichtel@6wind.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, dasaratharaman.chandramouli@intel.com,
        maheshkhanwalkar@gmail.com, mikedanese@google.com,
        ben@decadent.org.uk, ghackmann@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <69fb17c2-4ce9-4fc6-b75f-91ffefbdb16b@osg.samsung.com>
Date: Tue, 20 Sep 2016 10:11:49 -0600
MIME-Version: 1.0
In-Reply-To: <20160919101001.22ba10d3@lwn.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/19/2016 10:10 AM, Jonathan Corbet wrote:
> On Mon, 19 Sep 2016 08:47:34 -0600
> Shuah Khan <shuahkh@osg.samsung.com> wrote:
> 
>> Move laptops examples to samples and remove it from Documentation
>> Makefile. Create a new Makefile to build laptops. It can be built
>> from top level directory or from laptops directory:
> 
> This one might be better called a "tool" rather than a "sample" - assuming
> it actually still works, of course.  It hasn't seen a real update in the
> Git era, which is a bit disconcerting.  Is it possible that this is dead
> code that we might want to just get rid of?

I can send a removal patch and see if anybody objects. :)

> 
> If it stays, Documentation/laptops/laptop-mode.txt needs an update.

Right. Looks like I missed Documentation updates for these moves. I get
that done in v2.

thanks,
-- Shuah
