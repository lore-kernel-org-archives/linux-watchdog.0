Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35021 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcHLGtP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Aug 2016 02:49:15 -0400
MIME-Version: 1.0
In-Reply-To: <CAKfKVtHubRMwdYUfFx1YaiwKjYR_uUBBgouCTaTahmK9DGq6gQ@mail.gmail.com>
References: <1470982664-13228-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1a86f6d6-fc92-81ec-eb07-669c2bda8b38@roeck-us.net> <CAKfKVtHubRMwdYUfFx1YaiwKjYR_uUBBgouCTaTahmK9DGq6gQ@mail.gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 12 Aug 2016 12:18:19 +0530
Message-ID: <CAKfKVtHaYSiHuU6WPsQtMrjASQPAwn6jeqw1oEAnZGcgaiLyuw@mail.gmail.com>
Subject: Re: [PATCHv4] watchdog: xilinx: Add clock support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>, wim@iguana.be
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 12, 2016 at 12:12 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
> [...]
>>
>>
>> The clock is optional. Why print anything ?
>>
>> I am not a friend of logging noise, and I think this is just noise.
>> Would you want such a message printed for each optional property ?
>>
>> Guenter
>>
> sure patch below
noticed some issue so sent by git
thanks,
