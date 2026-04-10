Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FD3E3C50
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842063; cv=none; b=m5qq0mfJH2mA6RK+CjjwVHPfsFkqV/z99t+qiOj/AYz+yEgICFa3hyZVRC9yL6j5jOgDLyTb9AIMVA64fLGGWqebj5PKDIUnJj+R8M+eHI3Nh6440txZoliww4gyHXe2XDfl5NGCxdP6N7D/3MSaRvWWulCwyFAqof3VWFSHfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842063; c=relaxed/simple;
	bh=4IMw3GWlufvJ/dDaFIfvHpTM5fSEwV14iaiM6URyhpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpnuvQjM450y28W+pJyPJrDDuO2MCSmOTZdnz2j5OGL9tYOXw1PtemfOnveBzmY5TmUSoEZ0avD49XFxarst7DSCbjXIdB+xHCPOZmzzAYQlhvVnal0uzkyuNS8C2Fy1J+nr3MAROpHiVvWttoBvXNACfd/pNj3zzlP0iNn/gBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLh1q1O0; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLh1q1O0"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so9774664c88.1
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775842061; x=1776446861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaxxoVZ/N6PYOpmH7IgxMu5sYWaYy96hqMrV/TeWyec=;
        b=dLh1q1O0QuzG6Kv0KVKslcR+8CvrTDJKtiAf3mWgd51KbD+VHqvgcdXRoIkqyGOEEq
         Q5cDs9LyG3MUdDZWisg3ucph2DWogX6Yz151ognG+SFsI+sn1SqrL2iMeoipvr54Bm5F
         lrVteXxKd5Yi4NtrohOZ3Ys/BbqDu4ayT84aJU3ooAiDhZcfYW95PdFEwGC66L0yNXe8
         YlVARtXhr3y9RdO3Ieh8KyXYRFw7RkpqxkDGBR6Hfslme5+zwcrpc2Plc2XOFfdajR+J
         IB67wsqvr7OC8uiY3ogSjMn4xWnbzWO0sCNESEr1VBZqj2iaXldbHGtMmMEdwD2sx6cE
         ozFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842061; x=1776446861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BaxxoVZ/N6PYOpmH7IgxMu5sYWaYy96hqMrV/TeWyec=;
        b=f792MNO2f9v8NmNKm17Juay6CfmLnFKArZubnOAfi+2ezXgBpOVdccY3rljg50a7/+
         B7mcIUFAzcWdTdryVR4KPKPCmCVy0VN9crGCETeAYTvbZcIRKHX0NpHo4A2vQxk0gCsP
         B39Zz0ce1P+eOLLrfV80U+H+FaJ/P99hP6fgJlqmAOTWO9ieOOApFUYRM4YQYB4RVHPm
         tRG63Y+4IwEqI8k07mc8v+jhuMQXE2CysimFttkwZLoeYAz6ZHR5NQEKzVp6sxXwa8Iz
         2OeQJiQN07hsFlISAh3Rj+/4i9xcZecZgOmBjGB5yZQKZJ9NZPcYoZMOTOzaTfdYPKoc
         EWoA==
X-Forwarded-Encrypted: i=1; AJvYcCWbXjN7T02yEyQoqtZ06ElLKPBj2dP0dKgU3JFfiqrjk/jd0zfhA3vhBBjvGmP/bzEaNQ3wNnsOALLAoX75Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cuykxB8WME6HoCLkFGvtDFL/7FPNY9dhMSkyXflVQ3YZ5Ha3
	c5BuiihhCkY6m/6cJu0kKGrLRSW0vqWX/pd9yvft6ojsAlf2xPhwc8lw
X-Gm-Gg: AeBDievOnemSjEvslHoJOuNxeZCkdgZhyUdS0Xnlkx25GmSDEOEph+qvjRwK3dGTMUS
	QBpdcO4NCZWgbNidsZQFGzKjbaVaF9iz9VBQCcVg7e9y2jeFJ+kSLDK+FGT2Zd/stJYtwDjrR+Z
	/ayVxsfn+jUIlJ0EOejL8RnsiYgZo3s+Nl1NtC9jXqfyZAWB+UvtKoUNTpAKWvSZHs31xu0U3GX
	0uDCQ+8UkdNSUR0Aet52twaPWjPZCYcxo0uAD5MR59Cix9oO2MrNAmCs9MVNunsIf+6Rbq7ETFa
	dQWrNdrl39IX+1kUztd1g3NtXOPDlJbYWu3qOofvvqfFb1sFrYdMY4pNQDBRRZ3zIV5zwIW56w0
	CH2iBtuv9iRRhChZpQ+bVTsuhUFFP7plO/9hq4NGNoh7ZzqB72KKZc3aN8uKiRK7PnBcFDUEjzR
	0Y7Lm4Ak4nXfuMDnGv78pNosJEQIZPBSEzuUYl
X-Received: by 2002:a05:7022:23a8:b0:128:ce44:be90 with SMTP id a92af1059eb24-12c34eeb7d4mr2293149c88.28.1775842061155;
        Fri, 10 Apr 2026 10:27:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34acb077sm3854245c88.6.2026.04.10.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:27:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 10:27:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Sunny Patel <nueralspacetech@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Refactored watchdog old doc
Message-ID: <3e25ae54-e62d-484e-8d90-4f7825705e4f@roeck-us.net>
References: <132f7e64-4fc6-4274-a04e-e53f0b957665@roeck-us.net>
 <20260410072825.19114-1-nueralspacetech@gmail.com>
 <fe3de980-e918-47ae-862a-969a5b117ae0@roeck-us.net>
 <87ik9y229e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik9y229e.fsf@trenco.lwn.net>

On Fri, Apr 10, 2026 at 10:45:01AM -0600, Jonathan Corbet wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
> > On Fri, Apr 10, 2026 at 12:58:11PM +0530, Sunny Patel wrote:
> >> Good Point. So again revisited the watchdog core
> >> api and list out the deprecated one and marked
> >> as deprecated in doc and also mentioned it just
> >> for legacy driver and not for newer one.
> >> 
> >> As someof the legacy driver still have reference 
> >> to old api so just marked as deprecated in doc.
> >> 
> >> Also checked with other watchdog related api
> >> which are deprecated in driver but still present 
> >> in doc but didn't find any.
> >> 
> >> ---
> >
> > The above would show up as commit message, there is no change log, and
> > this e-mail was sent as response to v1. And I can see that without even
> > looking at the patch itself.
> >
> > That makes me wonder what Documentation/process/submitting-patches.rst
> > is useful for. No one seems to bother reading it. We might as well
> > just remove it.
> 
> It's good to point people at.
> 
> I do think it needs a serious rewrite to, among other things, turn it
> into less of an intimidating tome.  On my list of things to do.  Now if
> I could only buy a larger drive to hold that whole list...
> 
Let's have some fun:

1st AI prompt:

You are an experienced Linux kernel developer and an AI prompt expert.
Read linux/Documentation/process/submitting-patches.rst and generate an
AI prompt file named review.md which can be used by an AI agent to review
a patch submission and determine if it follows the guidance in
submitting-patches.rst.

2nd AI prompt:

Using @review.md, review the patch in index.html, which targets the
repository in the linux/ directory. Provide review output in review.log.

Result is below (raw file as generated by the AI agent, not reformatted).

Guenter

---
Status: NEEDS WORK

Summary:
The patch updates the watchdog API documentation by marking deprecated ioctls and adding descriptions for features like MAGICCLOSE and PRETIMEOUT. While the technical content is useful, the patch requires revisions to the commit 
message and documentation text to fix typos, grammatical errors, and formatting issues.

Detailed Findings:
1. Commit Message & Description:
   - The description starts with conversational filler ("Good Point. So again revisited...") which should be removed.
   - The message is not written in the imperative mood (e.g., use "Mark WDIOC_GETTEMP as deprecated" instead of "Revisited... and marked...").
   - Typos in the commit message: "someof" (some of), "Reierate" (Reiterate).
   - The subject line "Documentation: Refactored watchdog old doc" should use the imperative mood: "Documentation: Refactor watchdog documentation".

2. Technical Content & Style:
   - Several typos in the documentation text:
     - "reboot tiemout" -> "reboot timeout" (Multiple occurrences).
     - "characted 'V'" -> "character 'V'".
     - "small number if legacy drivers" -> "small number of legacy drivers".
   - Grammatical/Formatting issues:
     - Missing space: "WDIOS_DISABLECARD,this" -> "WDIOS_DISABLECARD, this".
     - Inconsistent capitalization: "USE WDIOC_SETPRETIMEOUT" should be "Use WDIOC_SETPRETIMEOUT".
     - "New Drivers" should be "New drivers".
   - The patch results in "No newline at end of file" for Documentation/watchdog/watchdog-api.rst.

3. Canonical Patch Format:
   - The patch follows the basic canonical format (Subject, From, Sign-off, separators, changelog, and diffstat are all present).

Actionable Advice:
1. Rewrite the commit message to be professional and in the imperative mood. Remove any conversational references to previous discussions.
2. Perform a spell-check on the documentation changes. Specifically, fix "tiemout", "characted", and "if" (where "of" was intended).
3. Ensure proper spacing after punctuation (e.g., after the comma in the WDIOS_DISABLECARD description).
4. Add a newline at the end of Documentation/watchdog/watchdog-api.rst.
5. Use consistent sentence-case for instructions (e.g., "Use" instead of "USE").

