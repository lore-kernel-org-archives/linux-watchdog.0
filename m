Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:50358 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbL1XSt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 18:18:49 -0500
Message-ID: <5681C2FE.7070100@mentor.com>
Date: Tue, 29 Dec 2015 01:17:18 +0200
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: Re: Additional patches in my watchdog-next branch
References: <20151228152335.GA18627@roeck-us.net> <20151228152710.GA31482@spo001.leaseweb.nl> <20151228215709.GA30595@roeck-us.net> <20151228225427.GA2018@spo001.leaseweb.nl>
In-Reply-To: <20151228225427.GA2018@spo001.leaseweb.nl>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On 29.12.2015 00:54, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
>> On Mon, Dec 28, 2015 at 04:27:11PM +0100, Wim Van Sebroeck wrote:
>>> Hi Guneter,
>>>
>>>> I have a number of patches pending in my watchdog-next branch which are not
>>>> in your watchdog-next repository. Below is a summary, rebased onto your
>>>> repository. This does not include the patches I had submitted.
>>>>
>>>> Please consider those patches for v4.5.
>>>
>>> I'm still working on those. Will be for this evening. I left those because they are all new drivers. I wanted to have all fixes and other patches first.
>>> So not finished yet :-) I will also add your dev fixes (V2 patchset containing 5 patches).
>>>
>> Thanks!
> 
> No problem. I think we now have all patches that should go in for v4.5 .
> 
> There is off course still other stuff that I need to look at:
> SBSA, pretimeout, bcm63xx, stmp3xxx GETBOOTSTATUS (although I have the impression that this patch is a dead end because you cannot really tell what the reboot reason is with the patch), soft timer's moving into the core, mei watchdog code, ...
> 

please let me know, if you want to see the proposed pretimeout change rebased earlier, at the moment it may have merge conflicts with your watchdog/master branch. In any case I would appreciate to get your review comments :)

--
With best wishes,
Vladimir
