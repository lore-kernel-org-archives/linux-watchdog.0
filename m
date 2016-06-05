Return-path: <Vladimir_Zapolskiy@mentor.com>
Subject: Re: [PATCH 1/7] watchdog: add watchdog pretimeout framework
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
 <1464183151-4912-2-git-send-email-wsa@the-dreams.de>
 <5747041B.2050707@mentor.com> <20160526164136.GB1631@katana>
 <20160526223717.GA6659@roeck-us.net> <20160605094823.GB1497@katana>
CC: <linux-watchdog@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	Robin Gong <b38343@freescale.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <57548AD7.6060503@mentor.com>
Date: Sun, 5 Jun 2016 23:25:59 +0300
MIME-Version: 1.0
In-Reply-To: <20160605094823.GB1497@katana>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Wolfram,

On 05.06.2016 12:48, Wolfram Sang wrote:
> On Thu, May 26, 2016 at 03:37:17PM -0700, Guenter Roeck wrote:
>> On Thu, May 26, 2016 at 06:41:36PM +0200, Wolfram Sang wrote:
>> [ ... ]
>>>
>>> No doubt about that. I had some ideas and thought it is easier to talk
>>> over code. If you want to rebase it, too, I'd be happy to check what you
>>> came up with to solve the problems. I might still argue that I prefer
>>> the less-code approach, but it will be Guenter's / Wim's decision, of
>>> course.
>>>
>> I have a large back-log of patches to review. Simple patches with less code
>> will get preferential treating. The more complex, the higher the likelyhood
>> that the patches get pushed to the end of the queue.
>>
>> Giving a quick glance, I liked Wolfram's patches because they seemed to
>> be simple and straightforward. I hope the next version won't add too much
>> additional complexity.
> 
> Vladimir, did you have time to look into this?

yes, I managed to rebase and split my change to smaller pieces to encourage
reviewers.

My plan is to do thorough testing of the change and send it for review
tomorrow or on Tuesday, please participate in review.

> I can offer to resend this series on-top of v4.7-rc1 with the core patch
> re-attributed to Vladimir. Then we can review the basic stuff now, and
> can discuss/deal with the bottom half handling incrementally.
> 
> Sounds good?
> 

--
Best wishes,
Vladimir
