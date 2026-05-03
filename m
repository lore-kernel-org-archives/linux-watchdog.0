Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEB294A10;
	Sun,  3 May 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821609; cv=none; b=FcJgWFaBOhoJA92Vn81f0owHneCiQb6f3AinLZE6mWzTqt4efmwkSINCPBbv0n85Y6FvezdDUwCqOTmxeKrDslmrfrQguce7RddYRob3gZr1x417ECr+AemtZqJUlYuFwmzCkvWvwZ0pjrvpdrmLmrSN47TNNfOmYN7HrAyaIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821609; c=relaxed/simple;
	bh=9ZQLZrpN6NElVWbLzuO0+GvkcQGqZk0/OsuHr2gFPS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMNZUevaeQbp0iFF17AOZDa/XJ/Ov6emlgmB18Oa7hwwoKpnNMdZnRiJwOfye6UY2KnOZZ7v2p1E+A9vLiPKH5GvaxYaGmOE/yvCpmG9f287911kVwiv1YOvjq7QqBLXcavb/M65QmWBEsSnT8+OKJ0HKQClQQac/pXmwoktA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OtrTiV6d; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OtrTiV6d"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5631341202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777821607; bh=hyfQhY3k7z88MNS6iDnDpL/YX26gYfj5GP8756dXVhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OtrTiV6dkVylcA+7ksi20vpk/wA/C644ENcRHpzt2R35cZvRxYyvfLCDuEaLjM7UZ
	 8gBp8DUouskYUu9Juj8ojbF2hGvON0k0m0dfPrOlYmUL7uFUy1BwncVsKkJ0FfB7il
	 QNnKLt00YsC21HmWKwedU3txcHUhdo88bpuAPK66862ZnM85kqU2MMwliboYkDrOGC
	 fJHkcfUKYI/kFAMGdomN8QDy7UgIOoOrZIr/JbQlLd8QhUGqzZoFsnOPKrvAQWPdcO
	 i88sGE4Y08vHGBPrnFJRDDj5fP0FMWV65G1o+xybzQluch9W6+5LUoZk+dXBAjA2t7
	 lFhKE907ZI9zg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5631341202;
	Sun,  3 May 2026 15:20:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Guenter Roeck <linux@roeck-us.net>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/5] docs: watchdog: general cleaning and corrections
In-Reply-To: <7a5971b2-e067-40cb-8d15-aaf1926af3c3@roeck-us.net>
References: <20260228010402.2389343-1-rdunlap@infradead.org>
 <875x7cddye.fsf@trenco.lwn.net>
 <3de4c724-39bf-47f9-bf43-49552bc60a3a@infradead.org>
 <8161ef45-be1a-41e2-a22b-a12d6b9df666@infradead.org>
 <7a5971b2-e067-40cb-8d15-aaf1926af3c3@roeck-us.net>
Date: Sun, 03 May 2026 09:20:05 -0600
Message-ID: <87tssobjve.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> On 4/30/26 15:14, Randy Dunlap wrote:
>> Hi Wim,
>> 
>> On 3/22/26 5:54 PM, Randy Dunlap wrote:
>>>
>>>
>>> On 3/3/26 9:23 AM, Jonathan Corbet wrote:
>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>>
>>>>> Fix some obvious issues in the watchdog documentation files.
>>>>> I didn't try to fix every little niggling mistake.
>>>>>
>>>>>   [PATCH 1/5] docs: watchdog: mlx-wdt: small fixes
>>>>>   [PATCH 2/5] docs: watchdog: pcwd: fix typo and driver info.
>>>>>   [PATCH 3/5] docs: watchdog-api: general cleaning
>>>>>   [PATCH 4/5] docs: watchdog-kernel-api: general cleanups
>>>>>   [PATCH 5/5] docs: watchdog-parameters: add missing watchdog_core parameters
>>>>>
>>>>>   Documentation/watchdog/mlx-wdt.rst             |    4 -
>>>>>   Documentation/watchdog/pcwd-watchdog.rst       |   19 +++++--
>>>>>   Documentation/watchdog/watchdog-api.rst        |   38 +++++++--------
>>>>>   Documentation/watchdog/watchdog-kernel-api.rst |   20 +++++--
>>>>>   Documentation/watchdog/watchdog-parameters.rst |   11 +++-
>>>>>   5 files changed, 58 insertions(+), 34 deletions(-)
>>>>
>>>> Wim, do you want to pick these up, or should I take them through the
>>>> docs tree?
>>>
>>> Wim, are you active?  Can you reply and/or merge these?
>> 
>> What's happening with these 5 patches?
>> 
>
> It looks like Wim did not send a pull request for watchdog this time around/
> Wim, are you still active, or should I send pull requests going forward ?

OK, rather than let these languish further, I've just applied them.

Thanks,

jon
