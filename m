Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39062 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755003AbcJMMgk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 13 Oct 2016 08:36:40 -0400
Subject: Re: [GIT PULL REQUEST] watchdog - v4.9 merge window
To: Wim Van Sebroeck <wim@iguana.be>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20161012183505.GA14975@spo001.leaseweb.nl>
 <CA+55aFzvd7cBENiVPWG3OsOH62SQdK-Df+jXbKmdp6hV2nUvGg@mail.gmail.com>
 <20161013055402.GA19874@spo001.leaseweb.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1e50a510-9f41-bbe5-6bb4-f3316f030f01@roeck-us.net>
Date: Thu, 13 Oct 2016 05:36:35 -0700
MIME-Version: 1.0
In-Reply-To: <20161013055402.GA19874@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/12/2016 10:54 PM, Wim Van Sebroeck wrote:
> Hi Linus,
>
> It's an old server with only 512Mb RAM. I'm in the progress off replacing it (in another datacenter).
> Meanwhile I'll restart git-daemon.
>

Linus,

if it still doesn't work, I pulled it, verified it, and pushed it into my repository at kernel.org
with a signed tag.

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-wim-v4.9

Guenter

> Sorry,
> Wim.
>
>> On Wed, Oct 12, 2016 at 11:35 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
>>> Hi Linus,
>>>
>>> Please pull from 'master' branch of
>>>         git://www.linux-watchdog.org/linux-watchdog.git
>>
>> That site really is very ill. It's timing out or getting "Connection
>> reset by peer" errors.
>>
>> How about just using something like github and signed tags? This is
>> not the first time inux-watchdog.org has had problems.
>>
>> (In fact, even withour switching to something like github, signed tags
>> would be a good thing).
>>
>>                    Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

