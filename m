Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93F37B002;
	Tue,  2 Jun 2026 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.87.125.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432676; cv=none; b=LJTlCVtTrHzLcYHpSINvYhBs6hpq3gEze76aShk1Y98otaD209hsbWC4QNvp7eY9XzC4vHAxZsZb/nkmc9mZIO1COpUqVD1bP+T4CexFH9ngqU2H7UEqmw/+3wwocy9QYUN6I8VKPfG1DeA/60B620Ng9JzJgvWXW6TA8GtfPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432676; c=relaxed/simple;
	bh=ZrWuGtLdaSBWv5exW3amT6fM6REngv93A/YCixazEUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqXS/6YIyOf5JtcemGUKnV5IA4H+Pz+N6H3RdorgdeaA+iHCxUnW9hFOhVv+P56NgqfhVPU48+7Lemmzs305qCQzRT4aNAvKEijUvtjGyPy537sRwUTmVtINyCHApStOX+6aNS9ItBM6Xvh9F2/38nJ/v4pwVrFJROSwJxSHbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org; spf=pass smtp.mailfrom=linux-watchdog.org; dkim=pass (2048-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b=OaPHYmGU; arc=none smtp.client-ip=185.87.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="OaPHYmGU"
Received: by www.linux-watchdog.org (Postfix, from userid 500)
	id 5974C40A08; Tue,  2 Jun 2026 21:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 5974C40A08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
	s=odk20250313; t=1780428737;
	bh=ZrWuGtLdaSBWv5exW3amT6fM6REngv93A/YCixazEUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaPHYmGUFGcjGn6so9ZELSkQaFVtdBWB67qlJWvxg6vVF+PR1+/X9XS6zRHVDypLG
	 l7ERH4KJr8WfWPMHPqvk39SYWxBIYM+Hm700v06WL/xblXb/Alp81uVRYBbBYmz0p0
	 xeZqTkh5mLS56N8nOqaufuzYSe9UGJ3wU0JYoJvg0vCtktQ5lEgvircNE8LGDEwp1Y
	 f7OZzPWGc6yV7BICzTCak7BPxBJg0j//iY2Cna8nQ+sXJcu5RY3Vz45Wx9fdd5mIPc
	 CiuavgzrQ3ZiuPEmauxdWElDAlSryrgSMtzbt+mAiIakYhOHKs9qRrJCLj6QOTRZ4N
	 tvoalBHN66kEQ==
Date: Tue, 2 Jun 2026 21:32:17 +0200
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Picking up watchdog pull requests starting with the 7.2 commit
 window
Message-ID: <20260602193217.GA28593@www.linux-watchdog.org>
References: <2ca2a562-f9b6-4a68-a3a6-1fe4c03e7b40@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca2a562-f9b6-4a68-a3a6-1fe4c03e7b40@roeck-us.net>
User-Agent: Mutt/1.5.20 (2009-12-10)

Hi All,

Due to health issues I indeed have been out for some time. It was not one perticular thing, but a series of small issues one after the other.
And when I was finally over the health issues some serious issues at work prevented me from having any spare time.

So first of all: my sincere apologies for being out so suddenly.
Secondly: Thanks Guenter for stepping in and taking over. I didn't want to "retire" as a maintainer like this, but I guess that's life.

It's indeed best that Guenter continues with the watchdog driver part and manages the trees.

Kind regards,
Wim.


> Hi all,
> 
> I have not heard from Wim recently, and he did not send a watchdog
> pull request for the 7.1 commit window.
> 
> Unless Wim informs me that this was an exception and that he will
> continue sending pull requests going forward, I'll handle watchdog
> subsystem pull requests starting with the 7.2 commit window.
> 
> Thanks,
> Guenter
> 
> 
