//
//  DHPwdHashUtil.m
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

static int between(int min, int interval, int offset);

#import "DHPwdHashUtil.h"

static NSString* sTopAnd2ndTierDomains = @"ab.ca|ac.ac|ac.at|ac.be|ac.cn|ac.il|ac.in|ac.jp|ac.kr|ac.nz|ac.th|ac.uk|ac.za|adm.br|adv.br|agro.pl|ah.cn|aid.pl|alt.za|am.br|arq.br|art.br|arts.ro|asn.au|asso.fr|asso.mc|atm.pl|auto.pl|bbs.tr|bc.ca|bio.br|biz.pl|bj.cn|br.com|cn.com|cng.br|cnt.br|co.ac|co.at|co.il|co.in|co.jp|co.kr|co.nz|co.th|co.uk|co.za|com.au|com.br|com.cn|com.ec|com.fr|com.hk|com.mm|com.mx|com.pl|com.ro|com.ru|com.sg|com.tr|com.tw|cq.cn|cri.nz|de.com|ecn.br|edu.au|edu.cn|edu.hk|edu.mm|edu.mx|edu.pl|edu.tr|edu.za|eng.br|ernet.in|esp.br|etc.br|eti.br|eu.com|eu.lv|fin.ec|firm.ro|fm.br|fot.br|fst.br|g12.br|gb.com|gb.net|gd.cn|gen.nz|gmina.pl|go.jp|go.kr|go.th|gob.mx|gov.br|gov.cn|gov.ec|gov.il|gov.in|gov.mm|gov.mx|gov.sg|gov.tr|gov.za|govt.nz|gs.cn|gsm.pl|gv.ac|gv.at|gx.cn|gz.cn|hb.cn|he.cn|hi.cn|hk.cn|hl.cn|hn.cn|hu.com|idv.tw|ind.br|inf.br|info.pl|info.ro|iwi.nz|jl.cn|jor.br|jpn.com|js.cn|k12.il|k12.tr|lel.br|ln.cn|ltd.uk|mail.pl|maori.nz|mb.ca|me.uk|med.br|med.ec|media.pl|mi.th|miasta.pl|mil.br|mil.ec|mil.nz|mil.pl|mil.tr|mil.za|mo.cn|muni.il|nb.ca|ne.jp|ne.kr|net.au|net.br|net.cn|net.ec|net.hk|net.il|net.in|net.mm|net.mx|net.nz|net.pl|net.ru|net.sg|net.th|net.tr|net.tw|net.za|nf.ca|ngo.za|nm.cn|nm.kr|no.com|nom.br|nom.pl|nom.ro|nom.za|ns.ca|nt.ca|nt.ro|ntr.br|nx.cn|odo.br|on.ca|or.ac|or.at|or.jp|or.kr|or.th|org.au|org.br|org.cn|org.ec|org.hk|org.il|org.mm|org.mx|org.nz|org.pl|org.ro|org.ru|org.sg|org.tr|org.tw|org.uk|org.za|pc.pl|pe.ca|plc.uk|ppg.br|presse.fr|priv.pl|pro.br|psc.br|psi.br|qc.ca|qc.com|qh.cn|re.kr|realestate.pl|rec.br|rec.ro|rel.pl|res.in|ru.com|sa.com|sc.cn|school.nz|school.za|se.com|se.net|sh.cn|shop.pl|sk.ca|sklep.pl|slg.br|sn.cn|sos.pl|store.ro|targi.pl|tj.cn|tm.fr|tm.mc|tm.pl|tm.ro|tm.za|tmp.br|tourism.pl|travel.pl|tur.br|turystyka.pl|tv.br|tw.cn|uk.co|uk.com|uk.net|us.com|uy.com|vet.br|web.za|web.com|www.ro|xj.cn|xz.cn|yk.ca|yn.cn|za.com";

@implementation DHPwdHashUtil


/*
 * 1) Extract the domain.
 *
 
 Original Javascript implementation:
 
 function SPH_DomainExtractor() { }
 
 SPH_DomainExtractor.prototype = {
 
 extractDomain: function(host) {
 
 var s; // the final result
 
 // Begin Chris Zarate's code
 host=host.replace('http:\/\/','');
 host=host.replace('https:\/\/','');
 re=new RegExp("([^/]+)");
 host=host.match(re)[1];
 host=host.split('.');
 
 if(host[2]!=null) {
 s=host[host.length-2]+'.'+host[host.length-1];
 domains='ab.ca|ac.ac|ac.at|ac.be|ac.cn|ac.il|ac.in|ac.jp|ac.kr|ac.nz|ac.th|ac.uk|ac.za|adm.br|adv.br|agro.pl|ah.cn|aid.pl|alt.za|am.br|arq.br|art.br|arts.ro|asn.au|asso.fr|asso.mc|atm.pl|auto.pl|bbs.tr|bc.ca|bio.br|biz.pl|bj.cn|br.com|cn.com|cng.br|cnt.br|co.ac|co.at|co.il|co.in|co.jp|co.kr|co.nz|co.th|co.uk|co.za|com.au|com.br|com.cn|com.ec|com.fr|com.hk|com.mm|com.mx|com.pl|com.ro|com.ru|com.sg|com.tr|com.tw|cq.cn|cri.nz|de.com|ecn.br|edu.au|edu.cn|edu.hk|edu.mm|edu.mx|edu.pl|edu.tr|edu.za|eng.br|ernet.in|esp.br|etc.br|eti.br|eu.com|eu.lv|fin.ec|firm.ro|fm.br|fot.br|fst.br|g12.br|gb.com|gb.net|gd.cn|gen.nz|gmina.pl|go.jp|go.kr|go.th|gob.mx|gov.br|gov.cn|gov.ec|gov.il|gov.in|gov.mm|gov.mx|gov.sg|gov.tr|gov.za|govt.nz|gs.cn|gsm.pl|gv.ac|gv.at|gx.cn|gz.cn|hb.cn|he.cn|hi.cn|hk.cn|hl.cn|hn.cn|hu.com|idv.tw|ind.br|inf.br|info.pl|info.ro|iwi.nz|jl.cn|jor.br|jpn.com|js.cn|k12.il|k12.tr|lel.br|ln.cn|ltd.uk|mail.pl|maori.nz|mb.ca|me.uk|med.br|med.ec|media.pl|mi.th|miasta.pl|mil.br|mil.ec|mil.nz|mil.pl|mil.tr|mil.za|mo.cn|muni.il|nb.ca|ne.jp|ne.kr|net.au|net.br|net.cn|net.ec|net.hk|net.il|net.in|net.mm|net.mx|net.nz|net.pl|net.ru|net.sg|net.th|net.tr|net.tw|net.za|nf.ca|ngo.za|nm.cn|nm.kr|no.com|nom.br|nom.pl|nom.ro|nom.za|ns.ca|nt.ca|nt.ro|ntr.br|nx.cn|odo.br|on.ca|or.ac|or.at|or.jp|or.kr|or.th|org.au|org.br|org.cn|org.ec|org.hk|org.il|org.mm|org.mx|org.nz|org.pl|org.ro|org.ru|org.sg|org.tr|org.tw|org.uk|org.za|pc.pl|pe.ca|plc.uk|ppg.br|presse.fr|priv.pl|pro.br|psc.br|psi.br|qc.ca|qc.com|qh.cn|re.kr|realestate.pl|rec.br|rec.ro|rel.pl|res.in|ru.com|sa.com|sc.cn|school.nz|school.za|se.com|se.net|sh.cn|shop.pl|sk.ca|sklep.pl|slg.br|sn.cn|sos.pl|store.ro|targi.pl|tj.cn|tm.fr|tm.mc|tm.pl|tm.ro|tm.za|tmp.br|tourism.pl|travel.pl|tur.br|turystyka.pl|tv.br|tw.cn|uk.co|uk.com|uk.net|us.com|uy.com|vet.br|web.za|web.com|www.ro|xj.cn|xz.cn|yk.ca|yn.cn|za.com';
 domains=domains.split('|');
 for(var i=0;i<domains.length;i++) {
   if(s==domains[i]) {
   s=host[host.length-3]+'.'+s;
   break;
   }
 }
 } else {
   s=host.join('.');
 }
 // End Chris Zarate's code
 return s;
 }
 }*/
+ (NSString*)extractDomain:(NSString*)url
{
    NSString* host = nil;
    
    url = [[[url stringByReplacingOccurrencesOfString:@"http://" withString:@""] stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    NSArray* domains = [sTopAnd2ndTierDomains componentsSeparatedByString:@"|"];
    NSArray* hostParts = [url componentsSeparatedByString:@"."];
    
    if (hostParts.count >= 3) {
        
        NSString* topDomain = [hostParts lastObject];
        NSString* secondDomain = [hostParts objectAtIndex:hostParts.count - 2];
        
        host = [NSString stringWithFormat:@"%@.%@", secondDomain, topDomain];
        
        for (NSString* top2ndPair in domains) {
            if ([top2ndPair isEqualToString:host]) {
                host = [NSString stringWithFormat:@"%@.%@", [hostParts objectAtIndex:hostParts.count - 3], host];
            }
        }
        
    } else {
        host = [hostParts componentsJoinedByString:@"."];
    }
    
    return host;
}

/*
 * 5) Remove the salt from the beginning of the hash result.
 */
+ (NSString*)removeSalt:(NSString*)salt FromHash:(NSString*)hash
{
    return [hash stringByReplacingOccurrencesOfString:salt withString:@""];
}

/*
 * 6) Check if the user supplied password was alphanumeric.
 */
+ (BOOL)isAlphaNumeric:(NSString*)password
{
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    return [password rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound;
}

/*
 * 7) Apply constraints to the remaining string (alphanumerical/non-alhpahnumerical, size)
 *
 * Fiddle with the password a bit after hashing it so that it will get through
 * most website filters. We require one upper and lower case, one digit, and
 * we look at the user's password to determine if there should be at least one
 * alphanumeric or not.

 Original Javascript implementation:

 function applyConstraints(hash, size, nonalphanumeric) {
 
 var startingSize = size - 3; // Leave room for some extra characters
 var result = hash.substring(0, startingSize);
 var extras = hash.substring(startingSize).split('');
 
 // Some utility functions to keep things tidy
 function nextExtra() { return extras.length ? extras.shift().charCodeAt(0) : 0; }
 function nextExtraChar() { return String.fromCharCode(nextExtra()); }
 function rotate(arr, amount) { while(amount--) arr.push(arr.shift()) }
 function between(min, interval, offset) { return min + offset % interval; }
 function nextBetween(base, interval) {
   return String.fromCharCode(between(base.charCodeAt(0), interval, nextExtra()));
 }
 function contains(regex) { return result.match(regex); }
 
   // Add the extra characters
   result += (contains(/[A-Z]/) ? nextExtraChar() : nextBetween('A', 26));
   result += (contains(/[a-z]/) ? nextExtraChar() : nextBetween('a', 26));
   result += (contains(/[0-9]/) ? nextExtraChar() : nextBetween('0', 10));
   while (contains(/\W/) && !nonalphanumeric) {
     result = result.replace(/\W/, nextBetween('A', 26));
   }
 
   // Rotate the result to make it harder to guess the inserted locations
   result = result.split('');
   rotate(result, nextExtra());
   return result.join('');
 }*/

+ (NSString*)applySize:(int)size
     AndAlphaNumerical:(BOOL)isAlphaNumeric
            ToPassword:(NSString*)password
{
    int startingSize = size - 3; // Leave room for some extra characters
    NSString* result = [password substringToIndex:startingSize];
    NSString* extras = [password substringFromIndex:startingSize];
    NSMutableArray* extraChars = [NSMutableArray array];
    for (int i = 0; i < [extras length]; i++) {
        [extraChars addObject:[NSNumber numberWithChar:[extras characterAtIndex:i]]];
    }
    
    if ([DHPwdHashUtil string:result
               ContainsAnyFrom:[NSCharacterSet uppercaseLetterCharacterSet]]) {
        result = [result stringByAppendingFormat:@"%c", [DHPwdHashUtil nextExtraChar:extraChars]];
    } else {
        result = [result stringByAppendingFormat:@"%c", [DHPwdHashUtil nextBetween:extraChars Base:'A' AndInterval:26]];
    }
    
    if ([DHPwdHashUtil string:result
              ContainsAnyFrom:[NSCharacterSet lowercaseLetterCharacterSet]]) {
        result = [result stringByAppendingFormat:@"%c", [DHPwdHashUtil nextExtraChar:extraChars]];
    } else {
        result = [result stringByAppendingFormat:@"%c", [DHPwdHashUtil nextBetween:extraChars Base:'a' AndInterval:26]];
    }
    
    if ([DHPwdHashUtil string:result
              ContainsAnyFrom:[NSCharacterSet decimalDigitCharacterSet]]) {
        result = [result stringByAppendingFormat:@"%c", [DHPwdHashUtil nextExtraChar:extraChars]];
    } else {
        result = [result stringByAppendingFormat:@"%c", [DHPwdHashUtil nextBetween:extraChars Base:'0' AndInterval:10]];
    }
    
    while (isAlphaNumeric && ![DHPwdHashUtil isAlphaNumeric:result]) {
        result = [DHPwdHashUtil replaceFirstNonAlphanumericalIn:result With:[DHPwdHashUtil nextBetween:extraChars Base:'A' AndInterval:26]];
    }
    
    NSMutableArray* resultChars = [NSMutableArray array];
    for (int i = 0; i < [result length]; i++) {
        [resultChars addObject:[NSNumber numberWithChar:[result characterAtIndex:i]]];
    }
    
    [DHPwdHashUtil rotate:resultChars ByAmount:[DHPwdHashUtil nextExtraChar:extraChars]];
    
    result = [NSString string];
    for (NSNumber* c in resultChars) {
        result = [result stringByAppendingFormat:@"%c", [c charValue]];
    }
    
    return result;
}

/*
 * Sub Tasks
 */
+ (NSString*)replaceFirstNonAlphanumericalIn:(NSString*)string With:(char)alphanumerical
{
    NSString* result;
    BOOL found = NO;
    NSMutableArray* chars = [NSMutableArray array];
    for (int i = 0; i < [string length]; i++) {
        
        char candidate = [string characterAtIndex:i];
        if (found
            || [[NSCharacterSet alphanumericCharacterSet] characterIsMember:candidate]) {
            [chars addObject:[NSNumber numberWithChar:candidate]];
        } else {
            found = YES;
            [chars addObject:[NSNumber numberWithChar:alphanumerical]];
        }
    }
    
    result = [NSString string];
    for (NSNumber* c in chars) {
        result = [result stringByAppendingFormat:@"%c", [c charValue]];
    }
    
    return result;
}

+ (BOOL)string:(NSString*)string ContainsAnyFrom:(NSCharacterSet*)set
{
    
    NSMutableArray* chars = [NSMutableArray array];
    for (int i = 0; i < [string length]; i++) {
        [chars addObject:[NSNumber numberWithChar:[string characterAtIndex:i]]];
    }
    
    for (NSNumber* c in chars) {
        if ([set characterIsMember:[c charValue]]) {
            return YES;
        }
    }
    
    return NO;
}

+ (char)nextExtraChar:(NSMutableArray*) extraChars
{
    char result = 0;
    
    if (extraChars.count > 0) {
        NSNumber* number = [extraChars objectAtIndex:0];
        result = [number charValue];
        [extraChars removeObjectAtIndex:0];
    }
    
    return result;
}

+ (char) nextBetween:(NSMutableArray*)extraChars Base:(char)base AndInterval:(char)interval
{
    return between(base, interval, [DHPwdHashUtil nextExtraChar:extraChars]);
}

+ (NSMutableArray*)rotate:(NSMutableArray*)array ByAmount:(int)amount
{
    while (array.count > 0 && amount--) {
        id element = [array objectAtIndex:0];
        [array removeObjectAtIndex:0];
        [array addObject:element];
    }
    
    return array;
}

@end

static int between(int min, int interval, int offset)
{
    return min + offset % interval;
}
