Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58406
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933141AbcITQJi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Sep 2016 12:09:38 -0400
Subject: Re: [PATCH 2/8] samples: move auxdisplay example code from
 Documentation
To: Jonathan Corbet <corbet@lwn.net>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
 <89e4e4ede7eb0c0ae5d72280455115612b0e4c98.1474073857.git.shuahkh@osg.samsung.com>
 <20160919100559.65391b6c@lwn.net>
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
Message-ID: <9adae72a-cfb2-75d1-bdb0-7c6f9b49d8dd@osg.samsung.com>
Date: Tue, 20 Sep 2016 10:09:32 -0600
MIME-Version: 1.0
In-Reply-To: <20160919100559.65391b6c@lwn.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/19/2016 10:05 AM, Jonathan Corbet wrote:
> On Mon, 19 Sep 2016 08:47:33 -0600
> Shuah Khan <shuahkh@osg.samsung.com> wrote:
> 
>> Move auxdisplay examples to samples and remove it from Documentation
>> Makefile. Create a new Makefile to build auxdisplay. It can be built
>> from top level directory or from auxdisplay directory:
> 
> Documentation/auxdisplay/cfag12864b needs to be updated to reflect the new
> home for the program (which probably does belong in samples/).
> 
> I wonder if these programs need MAINTAINERS entries too?
> 
> jon
> 

I will make sure Documentation and MAINTAINERS update happens in v2 patch
for this change.

thanks,
-- Shuah

