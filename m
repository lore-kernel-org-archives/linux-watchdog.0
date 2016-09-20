Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58360
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbcITQFi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Sep 2016 12:05:38 -0400
Subject: Re: [PATCH 1/8] samples: move accounting example code from
 Documentation
To: Jonathan Corbet <corbet@lwn.net>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
 <a73182df44d0827ed6338c082a8ea16d6d2bd0b8.1474073857.git.shuahkh@osg.samsung.com>
 <20160919100220.3581d122@lwn.net>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        tomas.winkler@intel.com, tglx@linutronix.de, wim@iguana.be,
        linux@roeck-us.net, elfring@users.sourceforge.net,
        nicolas.dichtel@6wind.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, dasaratharaman.chandramouli@intel.com,
        maheshkhanwalkar@gmail.com, mikedanese@google.com,
        ben@decadent.org.uk, ghackmann@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org,
        shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <d535cd06-c661-3232-db2a-9334e04a6b0a@osg.samsung.com>
Date: Tue, 20 Sep 2016 10:05:25 -0600
MIME-Version: 1.0
In-Reply-To: <20160919100220.3581d122@lwn.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/19/2016 10:02 AM, Jonathan Corbet wrote:
> On Mon, 19 Sep 2016 08:47:32 -0600
> Shuah Khan <shuahkh@osg.samsung.com> wrote:
> 
>> Move accounting examples to samples and remove it from Documentation
>> Makefile. Create a new Makefile to build accounting. It can be built
>> from top level directory or from accounting directory:
> 
> So I like the basic idea of these patches; it's the direction we've been
> trying to push things for a little bit.  I have a couple of specific
> comments for this one that may well apply to the others as well.
> 
> 1) Is samples the right destination for these utilities?  Some of them
>    might well be better placed under tools/ instead.  I'm not sure we've
>    ever formally stated the purpose of those two subtrees; I see samples/
>    as demonstrations of how to use something, while tools/ are utilities
>    you might actually want to use for some purpose.  Something like
>    getdelays might well fall into the latter group.  But maybe others
>    disagree?

getdelays stumped me a bit. My first choice was tools and then I noticed
that the documentation says it is a tool and an example usage of taskstruct.
I am not set on tools or samples as location for this. I can move it to
tools instead.

> 
> 2) Tools like getdelays are referenced in the documents that have been
>    left behind; see accounting/delay-accounting.txt, for example.  Those
>    documents should be updated so that readers know where to find the
>    referenced programs, wherever they end up.  Converting them to Sphinx
>    while you're at it is an extra-credit exercise :)

Right. Documents need updates and also the 00-Index files. I agree with
you that converting to Sphinx makes sense. There will be some learning
curve on my part. I can take this one once the move happens and do the
Documentation and 00-Index file updates.

thanks,
-- Shuah
