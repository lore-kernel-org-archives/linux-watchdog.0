Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54551 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab3HaN4t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 31 Aug 2013 09:56:49 -0400
Message-ID: <5221F61D.60009@roeck-us.net>
Date: Sat, 31 Aug 2013 06:56:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	IDE-ML <linux-ide@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Eric Paris <eparis@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	David Howells <dhowells@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/7] Drop support for Renesys H8/300 architecture
References: <1377880842-6835-1-git-send-email-linux@roeck-us.net> <20130830184611.GA27455@spo001.leaseweb.com> <20130830191146.GA12090@roeck-us.net> <CA+55aFyxHsKhtqqz9jTDYo89bCNqCWhjHGJ4HzFrHnJ0yxLXjQ@mail.gmail.com> <20130830193740.GA13101@roeck-us.net> <CAMuHMdW6KcHbpR_KzbTg9V_FJ8XvQAWQOB-2jXQxG5fo1wWg1A@mail.gmail.com>
In-Reply-To: <CAMuHMdW6KcHbpR_KzbTg9V_FJ8XvQAWQOB-2jXQxG5fo1wWg1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/30/2013 11:44 PM, Geert Uytterhoeven wrote:
> On Fri, Aug 30, 2013 at 9:37 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Fri, Aug 30, 2013 at 12:14:20PM -0700, Linus Torvalds wrote:
>>> On Fri, Aug 30, 2013 at 12:11 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> I would not mind if Linus would agree to pull it right away for 3.12,
>>>> but that seems to be a bit on the fast side.
>>>
>>> I'm ok with code deletion patches, I don't think that would be a
>>> problem. I didn't check them, but I assume this is all literally just
>>> removing code that is conditional on h8/300 config options?
>>>
>> Yes.
>>
>> I found a couple more since I sent the series, but nothing significant.
>>
>> What is your preference - keep it until 3.13, or prepare it now and send you
>> a pull request for 3.12 ?
>
> It would be nice to check with Sato-san, who wanted to attend Kernel
> Summit as a hobbyist architecture maintainer, and see what are his plans
> and opinions.
>

Yes, of course. My bad that my send script dropped him of all people from the
original e-mail :(. I fixed that in version 2.

Guenter

