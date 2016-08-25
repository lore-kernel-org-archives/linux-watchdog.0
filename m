Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38846 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbcHYS7k (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 Aug 2016 14:59:40 -0400
Date: Thu, 25 Aug 2016 11:59:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-watchdog@vger.kernel.org
Subject: Re: pre-timeout again?
Message-ID: <20160825185930.GB16420@roeck-us.net>
References: <20160824123510.GB5190@katana>
 <d396484c-d8c6-1212-1fde-0059cc594e3c@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d396484c-d8c6-1212-1fde-0059cc594e3c@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 24, 2016 at 09:19:28PM +0300, Vladimir Zapolskiy wrote:
> Hi Wolfram,
> 
> On 08/24/2016 03:35 PM, Wolfram Sang wrote:
> >Hi,
> >
> >I'd really like to see pretimeout support added in v4.9. Can't I just
> >resend my latest series (since Vladimir's latest series had some issues
> >which were already fixed in mine IIRC)? I still think this provides a
> >solid ground where Vladimir could add the missing features on top. I can
> >remove my copyright line, too, if that is important.
> 
> copyright is not an issue for me, the authorship is.
> 
> I'm not sure about the diff of the known issues between your and my series,
> IIRC the changes you had sent one day were not reviewed thoroughly.
> 
> >It's a bit sad that I have time assigned to this task but am basically
> >blocked currently. Or were there other issues I forgot?
> >
> 
> It's a bit sad that two your patches were not integrated to v4.8:
> 
>   http://www.spinics.net/lists/linux-watchdog/msg09484.html
> 
I don't recall seeing v3. Did I miss it ?

Guenter
